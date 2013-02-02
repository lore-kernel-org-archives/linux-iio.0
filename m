Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:58421 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757983Ab3BBQOn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 11:14:43 -0500
Date: Sat, 2 Feb 2013 08:14:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [RFC 10/11] iio: Add OF support
Message-ID: <20130202161448.GD10386@roeck-us.net>
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net>
 <1359668588-13678-11-git-send-email-linux@roeck-us.net>
 <510BADCA.1030407@metafoo.de>
 <20130201143307.GB20767@roeck-us.net>
 <510BD845.1010200@metafoo.de>
 <20130201194213.GA17968@roeck-us.net>
 <510D24BA.5000300@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <510D24BA.5000300@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Feb 02, 2013 at 03:37:46PM +0100, Lars-Peter Clausen wrote:
> On 02/01/2013 08:42 PM, Guenter Roeck wrote:
> > On Fri, Feb 01, 2013 at 03:59:17PM +0100, Lars-Peter Clausen wrote:
> >> On 02/01/2013 03:33 PM, Guenter Roeck wrote:
> >>> On Fri, Feb 01, 2013 at 12:58:02PM +0100, Lars-Peter Clausen wrote:
> >>>> 013 10:43 PM, Guenter Roeck wrote:
> >>>>> Provide bindings, new API access functions, and parse OF data
> >>>>> during initialization.
> >>>>>
> >>>>
> >>>> Hi Guenter,
> >>>>
> >>>> Thanks for taking care of this.
> >>>>
> >>>> I'd prefer to have only one iio_get_channel which handles both the dt and the
> >>>> non-dt case. Otherwise we'll soon have constructs like
> >>>>
> >>>> if (dev->of_node)
> >>>> 	chan = of_iio_get_channel(dev->of_node, 1);
> >>>> else
> >>>> 	chan = iio_get_channel(dev_name(dev), "vcc");
> >>>>
> >
> > Clock code has of_clk_get_by_name(node *, name), clk_get(dev, name), and
> > of_clk_get(node *, index). Right now of_iio_get_channel matches of_clk_get,
> > and iio_get_channel matches clk_get.
> >
> > Question is really how we want to API to look like. I am open to suggestions.
> 
> I'm not necessarily against having a separate of_iio_get_channe function, but
> I'm not sure if we really need it, maybe use it internally as a helper and if
> we really need it in some driver make it public and export it. clk_get first
> calls of_clk_get_by_name, and only if didn't find a clk it falls back to the
> map based lookup. I think iio_get_channel should behave the similar. of_clk_get
> is kind of just a helper function for of_clk_get_by_name, not sure if we need
> it as a separate function in IIO. If we find out we need it we can probably
> still add it later.
> 
You are right. If I modify iio_get_channel to take the device pointer as
argument, it should work for both OF and non-OF with the approach you outlined
above.

Thanks,
Guenter
