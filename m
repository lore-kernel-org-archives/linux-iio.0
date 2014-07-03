Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:46491 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457AbaGCRyx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 3 Jul 2014 13:54:53 -0400
Message-ID: <53B5996C.5000204@kernel.org>
Date: Thu, 03 Jul 2014 18:57:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
CC: Fabio Estevam <festevam@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Samuel Ortiz <sameo@linux.intel.com>,
	=?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>,
	linux-iio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Denis Carikli <denis@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/6] input: touchscreen: imx25 tcq driver
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de> <1402672899-6995-1-git-send-email-denis@eukrea.com> <1402672899-6995-3-git-send-email-denis@eukrea.com> <53A55BD8.7030905@kernel.org> <CAOMZO5BxZDX5TDZdUCbpTw2LpVC=vr4cnn4eSpzd_023wcy+Fg@mail.gmail.com> <53AFF1C4.1010402@kernel.org> <20140629114901.GO32514@n2100.arm.linux.org.uk>
In-Reply-To: <20140629114901.GO32514@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/14 12:49, Russell King - ARM Linux wrote:
> On Sun, Jun 29, 2014 at 12:00:20PM +0100, Jonathan Cameron wrote:
>> On 21/06/14 20:55, Fabio Estevam wrote:
>>> On Sat, Jun 21, 2014 at 7:18 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>>> +
>>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>
>>>> Could this not in theory fail?
>>>
>>> Yes, but devm_ioremap_resource will take care of it, so we don't need
>>> to check for error here.
>> Nothing like counter intuitive behaviour.  Ah well.
>>
>> Thanks for explaining this!
>
> Maybe it would be better to have:
>
> 	mem = platform_ioremap_resource(pdev, IORESOURCE_MEM, 0);
>
> which wraps up both the platform_get_resource() call with
> devm_ioremap_resource() so driver writers don't have to be concerned
> about this aspect?
>
Good idea.

Something like that would certainly make more sense to me.
