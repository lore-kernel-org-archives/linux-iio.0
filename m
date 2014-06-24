Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:20682 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbaFXKir (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 24 Jun 2014 06:38:47 -0400
Message-ID: <53A95533.8090500@eukrea.com>
Date: Tue, 24 Jun 2014 12:38:43 +0200
From: Denis Carikli <denis@eukrea.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>,
	Devicetree List <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] iio: adc: fsl,imx25-gcq driver
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de> <1402672899-6995-1-git-send-email-denis@eukrea.com> <1402672899-6995-4-git-send-email-denis@eukrea.com> <53A55EDF.4010104@kernel.org>
In-Reply-To: <53A55EDF.4010104@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/21/2014 12:30 PM, Jonathan Cameron wrote:
>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),    \
> No known info on converting this to real voltages?  I'd normally expect
> a scale parameter at least with any raw channel output, but fair enough
> if it's not obvous what this should be.

We know the internal reference voltage.
We can also know the external reference voltage by representing it as a 
regulator.

Since there are many combinations should a regulator for each 
reference(external reference, xp, yp, xn and yn) be used?

Denis.
