describe('Dashboard', () => {
    it('opens the page correctly', function () {
        cy.visit('/')
        cy.get('body', { timeout: 10000 }).should(($body) => {
            const text = $body.text()
            expect(text.includes('Connecting to localhost') || text.includes('Standby')).to.equal(true)
        })
    })
})
