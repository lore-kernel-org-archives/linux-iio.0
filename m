Return-Path: <lee.jones@linaro.org>
Date: Mon, 12 Sep 2016 16:07:15 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, jdelvare@suse.com,
	linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160912150715.GG9789@dell>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
 <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
 <20160912095923.GD1873@dell>
 <20160912100719.GJ9449@lukather>
 <20160912104932.GF1873@dell>
 <c322d309-993c-a572-5ffd-bf4012e26134@free-electrons.com>
 <20160912135655.GC9789@dell>
 <20160912143548.GL9449@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160912143548.GL9449@lukather>
List-ID: <linux-iio@vger.kernel.org>

On Mon, 12 Sep 2016, Maxime Ripard wrote:

> On Mon, Sep 12, 2016 at 02:56:55PM +0100, Lee Jones wrote:
> > > >>> Then use .data = <defined model ID> and set up a switch() in .probe().
> > > >>
> > > >> Uh? Why? It just adds a non-standard indirection, while using
> > > >> of_match_device is very standard, and used extensively in Linux.
> > > > 
> > > > You still use of_match_device() to obtain the ID.
> > > > 
> > > > The "don't mix DT with the MFD API" is there to prevent some of the
> > > > nasty hacks I've seen previously.  This particular example doesn't
> > > > seem so bad, but it's a gateway to ridiculous hackery!
> > > 
> > > How am I supposed to get the .data without of_match_node then?
> > > What's more hackish in using .data field for specific data for each
> > > compatible than in using a random ID in .data and switching on it? The
> > > result is exactly the same, the switching case being more verbose and
> > > adding complexity to something that can be done in a straightforward manner.
> > 
> > I've already agreed that your implementation isn't terrible, but I'd
> > still like to remain strict on the rules.
> > 
> > Better still, can you can dynamically test which platform you're on,
> > via a version register or similar?
> > 
> > Failing that, see how everyone else does it:
> > 
> >  `git grep "\.data" -- drivers/mfd/`
> 
> Just to make sure, you prefer something like
> 
> static struct my_struct data = {
> };
> 
> static struct my_struct data2 = {
> };
> 
> struct of_device_id matches[] = {
>        { compatible = "...", data = <ID> },
>        { compatible = "...", data = <ID2> },
> };
> 
> of_id = of_match_device (dev, matches);
> switch (of_id->data) {
> case <ID>:
>      function(data);
> case <ID2>:
>      function(data2);
> };
> 
> over
> 
> static struct my_struct data = {
> };
> 
> static struct my_struct data2 = {
> };
> 
> struct of_device_id matches[] = {
>        { compatible = "...", data = data },
>        { compatible = "...", data = data2 },
> };
> 
> of_id = of_match_device (dev, matches);
> function(of_id->data);
> 
> ?
> 
> This is the *only* time this is going to be used in that driver. I can
> understand the need for a version if you need to apply quirks in
> several functions, but here it clearly looks suboptimal.
> 
> And we are indeed using this construct in the AXP MFD, and it just
> doesn't scale either and become quite difficult to maintain when you
> have a significant number of variants, and then you have to patch
> *all* the switch instances to get something done.

static struct my_struct data = {
};

static struct my_struct data2 = {
};

struct of_device_id matches[] = {
       { compatible = "...", data = <ID> },
       { compatible = "...", data = <ID2> },
};

int probe()
{
	struct mfd_cell *cell;

	of_id = of_match_device (dev, matches);
	switch (of_id->data) {
	case <ID>:
     	     cell = data;
	case <ID2>:
     	     cell = data2;
	};

	mfd_add_devices(..., cell, ...)
};

It's an extra few lines, but worth it to unbind MFD from DT.

Is there really no way to obtain this information dynamically?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
