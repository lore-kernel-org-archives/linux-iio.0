Return-Path: <linux+jic23=kernel.org@arm.linux.org.uk>
Date: Sun, 29 Jun 2014 12:49:01 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	linux-iio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Denis Carikli <denis@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>, linux-input@vger.kernel.org,
	Markus Pargmann <mpa@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
Message-ID: <20140629114901.GO32514@n2100.arm.linux.org.uk>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de> <1402672899-6995-1-git-send-email-denis@eukrea.com> <1402672899-6995-3-git-send-email-denis@eukrea.com> <53A55BD8.7030905@kernel.org> <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com> <53AFF1C4.1010402@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53AFF1C4.1010402@kernel.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jun 29, 2014 at 12:00:20PM +0100, Jonathan Cameron wrote:
> On 21/06/14 20:55, Fabio Estevam wrote:
>> On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>> +
>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>
>>> Could this not in theory fail?
>>
>> Yes, but devm_ioremap_resource will take care of it, so we don't need
>> to check for error here.
> Nothing like counter intuitive behaviour.  Ah well.
>
> Thanks for explaining this!

Maybe it would be better to have:

	mem = platform_ioremap_resource(pdev, IORESOURCE_MEM, 0);

which wraps up both the platform_get_resource() call with
devm_ioremap_resource() so driver writers don't have to be concerned
about this aspect?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
