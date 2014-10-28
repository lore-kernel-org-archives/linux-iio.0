Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55448 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbaJ1KTd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Oct 2014 06:19:33 -0400
From: Kukjin Kim <kgene@kernel.org>
To: 'Jonathan Cameron' <jic23@kernel.org>,
	'Naveen Krishna Chatradhi' <ch.naveen@samsung.com>,
	linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org
References: <1410857931-4980-1-git-send-email-ch.naveen@samsung.com>
 <541EC1C2.6090608@kernel.org> <5436EA85.90900@kernel.org>
 <544C04E6.50401@kernel.org>
In-reply-to: <544C04E6.50401@kernel.org>
Subject: RE: [PATCH v2 0/3] iio: exynos-adc: use syscon instead of ioremap
Date: Tue, 28 Oct 2014 19:19:22 +0900
Message-id: <03d601cff298$a4bacc90$ee3065b0$@kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron wrote:
> 
> On 09/10/14 21:05, Jonathan Cameron wrote:
> > On 21/09/14 13:17, Jonathan Cameron wrote:
> >> On 16/09/14 09:58, Naveen Krishna Chatradhi wrote:
> >>> Changes since v1:
> >>> 1. Rebased on top of togreg branch of IIO git.
> >>>
> >>> This patch set does the following
> >>> 1. Use the syscon and Regmap API instead of ioremappaing the
> >>>    ADC_PHY register from PMU.
> >>> 2. Updates the Documentation in exynos-adc.txt with syscon phandle
> >>>    for the ADC nodes.
> >>> 3. Updates the Dts files for Exynos3250, Exynos4x12, Exynos5250,
> >>>    Exynos5420 with the syscon phandle.
> >>>
> >>> Tested on Exynos5420 based Peach PIT and Exynos5800 based Peach PI
> >>> by verifying sysfs entries provided by HWMON based NTC thermistors.
> >>>
> >>> Tested-By for Exynos3250, Exynos4x12 would be appreciated.
> >> Would definitely be good!
> >>
> >> The main issue I have with this series is that it breaks backward
> >> compatibility with old device trees and newer kernels.
> >>
> >> Now I appreciate that sometimes there are reasons to do it but want this
> >> to have deeper consideration (and acks to show it) from the Exynos side
> >> of things and preferably from the device tree side of things as well.
> >>
> >> cc'd Kukjin Kim for the Exynos side of things as the listed Maintainer.
> >>
> >> Otherwise, the series looks fine to me.
> > Kukjin? Sorry to pester, but this has been sat in my waiting queue for a
> > while now.
> This is still sitting here waiting for those acks from Exynos side of things.
> I'm happy to let this sit indefinitely, but does seem a little silly.
> >>>

Thanks for asking :)

Since I've missed the patch in my mailbox and just now checked. I'm happy with
Naveen's dt updates, I'm not sure we can see useless merge conflicts though ;)
Anyway it should be small, so please feel free to add my ack on the change.

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

- Kukjin

> >>> Naveen Krishna Chatradhi (3):
> >>>   iio: exyno-adc: use syscon for PMU register access
> >>>   Documentation: dt-bindings: update exynos-adc.txt with syscon handle
> >>>   ARM: dts: exynos: Add sysreg phandle to ADC node
> >>>
> >>>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |    9 ++++--
> >>>  arch/arm/boot/dts/exynos3250.dtsi                  |    3 +-
> >>>  arch/arm/boot/dts/exynos4x12.dtsi                  |    3 +-
> >>>  arch/arm/boot/dts/exynos5250.dtsi                  |    3 +-
> >>>  arch/arm/boot/dts/exynos5420.dtsi                  |    3 +-
> >>>  drivers/iio/adc/exynos_adc.c                       |   30 ++++++++++++++------
> >>>  6 files changed, 36 insertions(+), 15 deletions(-)

