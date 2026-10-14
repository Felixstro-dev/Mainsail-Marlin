describe('Marlinraker integration', () => {
    it('loads printer data through the adapter websocket', () => {
        const socketUrls: string[] = []

        cy.visit('/', {
            onBeforeLoad(window) {
                const NativeWebSocket = window.WebSocket
                window.WebSocket = class extends NativeWebSocket {
                    constructor(url: string | URL, protocols?: string | string[]) {
                        socketUrls.push(String(url))
                        super(url, protocols)
                    }
                } as typeof WebSocket
            },
        })

        cy.contains('Standby', { timeout: 15000 }).should('exist')
        cy.contains('felix-stromfresser').should('exist')
        cy.contains('demo.gcode').should('exist')
        cy.contains('Extruder').should('exist')
        cy.contains('Console').should('exist')
        cy.wrap(null).should(() => {
            expect(socketUrls).to.include('ws://127.0.0.1:7125/websocket')
        })
    })
})
