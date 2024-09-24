class DerivedNavPathStack extends NavPathStack {
  id: string = "_default_"

  setId(id: string) {
    this.id = id
  }

  getInfo(): string {
    return "this page used Derived NavPathStack, id: " + this.id
  }

  pushPath(info: NavPathInfo, animated?: boolean): void
  pushPath(info: NavPathInfo, options?: NavigationOptions): void
  pushPath(info: NavPathInfo, secArg?: boolean | NavigationOptions): void {
    console.log('[derive-test] reached DerivedNavPathStack\'s pushPath')
    if (typeof secArg === "boolean") {
      super.pushPath(info, secArg)
    } else {
      super.pushPath(info, secArg)
    }
  }

  pop(animated?: boolean | undefined): NavPathInfo | undefined
  pop(result: Object, animated?: boolean | undefined): NavPathInfo | undefined
  pop(result?: Object, animated?: boolean | undefined): NavPathInfo | undefined {
    console.log('[derive-test] reached DerivedNavPathStack\'s pop')
    return super.pop(result,animated)
  }
}