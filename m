Return-Path: <lee.jones@linaro.org>
Date: Wed, 31 Aug 2016 12:56:55 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, jdelvare@suse.com,
	linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: Re: [PATCH v3 3/4] mfd: mfd-core: reattach mfd of_node to cells
 without of_compatible
Message-ID: <20160831115655.GE8649@dell>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160809134847.GJ5243@dell>
 <20160824063853.GB8103@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160824063853.GB8103@lukather>
List-ID: <linux-iio@vger.kernel.org>

On Wed, 24 Aug 2016, Maxime Ripard wrote:

> Hi Lee,
> 
> On Tue, Aug 09, 2016 at 02:48:47PM +0100, Lee Jones wrote:
> > On Tue, 26 Jul 2016, Quentin Schulz wrote:
> > 
> > > When an MFD cell has an of_compatible (meaning it is present in the Device
> > > Tree), other nodes can reference it using a phandle.
> > > 
> > > However when the MFD cell is not declared in the Device Tree, the only way
> > > other nodes can reference it are by using a phandle to the MFD. Then when
> > > this MFD cell tries to register itself in one framework, the registration
> > > is denied by the framework because it is not matching the of_node of the
> > > node which is referenced by the phandle in one of the other nodes.
> > > 
> > > This reattaches the of_node of the MFD to the MFD cell device structure
> > > when the MFD cell has no of_compatible.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > ---
> > > 
> > > We need this modification to register the thermal sensor in the thermal
> > > framework.
> > > 
> > > Added in v3.
> > > 
> > >  drivers/mfd/mfd-core.c | 14 +++++++++-----
> > >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > Can you show me the DT code where this is used?
> > 
> > Is it used by a patch in this series?
> 
> Yes and no.
> 
> This is not used directly by any code found in those patches.
> 
> However, those patches are actually a rewrite of an existing driver
> that was there before (drivers/input/touchscreen/sun4i-ts.c), that
> already had some DT bindings and was enabled in a few DT already [1].
> 
> The issue here is that for the new driver to be able to follow the
> phandles as it used to (which is also already used [2]). Obviously, in
> the usual mechanism (at least when you don't declare the mfd childs in
> the DT), the childs won't have any of_node associated to it, and this
> is fine in most cases.
> 
> This is where things get messy. The MFD childs will also register to
> their framework without, and then the whole phandle lookup goes nuts,
> because the phandles will point to the MFD's of_node, but no one will
> actually be registered anywhere with that of_node, which means that we
> broke all the links expressed by the phandles.

I'm concerned that this change may have unintended side-effects for
existing drivers.  Can you point me to the C code where this is
causing an issue.  Perhaps we can solve the issue without changing
subsystem core code.  By doing so we reduced the chance of
destructive ramifications for others.

> 1: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun7i-a20.dtsi#n1520
> 2: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun7i-a20.dtsi#n130
> 



-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
