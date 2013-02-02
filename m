Return-Path: <lars@metafoo.de>
Message-ID: <510D24BA.5000300@metafoo.de>
Date: Sat, 02 Feb 2013 15:37:46 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 devicetree-discuss@lists.ozlabs.org,
 Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
 Doug Anderson <dianders@chromium.org>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 Grant Likely <grant.likely@secretlab.ca>,
 Rob Herring <rob.herring@calxeda.com>
Subject: Re: [RFC 10/11] iio: Add OF support
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-11-git-send-email-linux@roeck-us.net> <510BADCA.1030407@metafoo.de> <20130201143307.GB20767@roeck-us.net> <510BD845.1010200@metafoo.de> <20130201194213.GA17968@roeck-us.net>
In-Reply-To: <20130201194213.GA17968@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/01/2013 08:42 PM, Guenter Roeck wrote:
> On Fri, Feb 01, 2013 at 03:59:17PM +0100, Lars-Peter Clausen wrote:
>> On 02/01/2013 03:33 PM, Guenter Roeck wrote:
>>> On Fri, Feb 01, 2013 at 12:58:02PM +0100, Lars-Peter Clausen wrote:
>>>> 013 10:43 PM, Guenter Roeck wrote:
>>>>> Provide bindings, new API access functions, and parse OF data
>>>>> during initialization.
>>>>>
>>>>
>>>> Hi Guenter,
>>>>
>>>> Thanks for taking care of this.
>>>>
>>>> I'd prefer to have only one iio_get_channel which handles both the dt and the
>>>> non-dt case. Otherwise we'll soon have constructs like
>>>>
>>>> if (dev->of_node)
>>>> 	chan = of_iio_get_channel(dev->of_node, 1);
>>>> else
>>>> 	chan = iio_get_channel(dev_name(dev), "vcc");
>>>>
>
> Clock code has of_clk_get_by_name(node *, name), clk_get(dev, name), and
> of_clk_get(node *, index). Right now of_iio_get_channel matches of_clk_get,
> and iio_get_channel matches clk_get.
>
> Question is really how we want to API to look like. I am open to suggestions.

I'm not necessarily against having a separate of_iio_get_channe function, but
I'm not sure if we really need it, maybe use it internally as a helper and if
we really need it in some driver make it public and export it. clk_get first
calls of_clk_get_by_name, and only if didn't find a clk it falls back to the
map based lookup. I think iio_get_channel should behave the similar. of_clk_get
is kind of just a helper function for of_clk_get_by_name, not sure if we need
it as a separate function in IIO. If we find out we need it we can probably
still add it later.

- Lars

>
>>>> appearing all over the place in drivers code. I'd keep the actual
>>>> implementation pretty close to what the clk framework does. E.g. take a
look at
>>>> of_clk_get_by_name() and clk_get() in clkdev.c. And don't take a detour
via the
>>>> iio_map lookup for the devicetree case, just loop over all IIO devices and
>>>> match by of_node. This should allow us to simplify the code quite a bit.
>>>>
>>> Yes, I just could not figure out how to loop over the list of iio devices. That
>>> is why I hijacked iio_map which does provide a list.
>>>
>>> Any hints ?
>>
>> Yes, use bus_find_device on iio_bus_type. A nice example how to use this to
>> lookup device by of node is of_find_i2c_device_by_node. For IIO you also need
>> to make sure that dev->type is iio_dev_type, since both devices and triggers
>> are registered on the same bus.
>>
> Great, that works nicely, and, yes, the code is now much simpler.
>
>>>>> +static struct iio_map *iio_map_of_init(struct iio_dev *idev)
>>>>> +{
>>>>
>>>> To be honest I find this whole function a bit confusing. If we are using
>>>> devicetree, we shouldn't need to register iio_map. Maybe just skip over
>>>> io-channel-output-names for now, until we figure out if we really need
this and
>>>> what for.
>>>>
> Correct, I don't need this anymore after implementing the above.
>
