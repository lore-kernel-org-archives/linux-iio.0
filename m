Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39808 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751575AbbGVTdu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jul 2015 15:33:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 2A6F220A80
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2015 15:33:50 -0400 (EDT)
Message-Id: <1437593628.2381718.330572297.2F6F1C50@webmail.messagingengine.com>
From: Graeme Gregory <gg@slimlogic.co.uk>
To: Belisko Marek <marek.belisko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Axel Lin <axel.lin@ingics.com>, linux-iio@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: linux-omap@vger.kernel.org,
	"Dr. H. Nikolaus Schaller" <hns@goldelico.com>, balajitk@ti.com,
	oleksandr.kozaruk@ti.com
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com>
References: <CAAfyv354=J+iDgLcu9KRZSScGSzYrRsCMmUEc_tW84GfduSebw@mail.gmail.com>
 <CAAfyv35bUMZKfMQDJYwD_uGRNOiqLqAB4UG=gREgCSWa8vhjdw@mail.gmail.com>
Subject: Re: twl6030-gpadc support for twl6037
Date: Wed, 22 Jul 2015 20:33:48 +0100
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Wed, 22 Jul 2015, at 08:28 PM, Belisko Marek wrote:
> Adding also twl6030-gpadc driver authors to loop
> 
> On Mon, Jul 20, 2015 at 8:57 AM, Belisko Marek <marek.belisko@gmail.com>
> wrote:
> > Hi all,
> >
> > I'm trying to figure out what is relation between palmas mfd driver
> > and twl-core for twl603x devices.
> > twl-core driver seems to be older than palmas driver but seems both
> > export same functionality (except that palmas have defined structs for
> > gpadc but functionality is missing). My main focus is to add support
> > for twl6037 to gpadc iio driver in iio/adc/twl6030-gpadc which is
> > using twl-core for twl6030 and twl6032. Adding twl6037 support should
> > be straightforward but dts file used in omap5-uevm using palmas driver
> > and not twl6030. So it's completely confusing to me how to proceed or
> > which direction is correct. Seems I'm missing some parts of puzzle ;)
> > Thanks for any hints.
> >
Phoenix is twl6030, twl6032

Palmas is twl6035, twl6037 and maybe others.

Phoenix and Palmas are two totally different chips but marketing gave
them numbers near each other for unknown reasons.

Graeme

