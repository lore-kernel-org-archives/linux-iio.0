Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:5831 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab2DRHEL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 03:04:11 -0400
Message-ID: <4F8E6756.80006@nvidia.com>
Date: Wed, 18 Apr 2012 12:33:50 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Stephen Warren <swarren@wwwdotorg.org>
CC: "olof@lixom.net" <olof@lixom.net>,
	Colin Cross <ccross@android.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 3/3] ARM: dt: tegra_ventana: als and proximity sensor
 isl29018 support
References: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com> <1334645155-13799-4-git-send-email-ldewangan@nvidia.com> <4F8DF01D.9040900@wwwdotorg.org>
In-Reply-To: <4F8DF01D.9040900@wwwdotorg.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday 18 April 2012 04:05 AM, Stephen Warren wrote:
> On 04/17/2012 12:45 AM, Laxman Dewangan wrote:
>> Add the device info for ALS and proximity sensor isl29018.
>> +		isl29018: isl29018@44 {
> I don't think the label "isl29018:" serves any purpose; nothing else
> needs to refer to this node.
>
> I note from http://patchwork.ozlabs.org/patch/132936/ that:
>
> a) Perhaps the vendor prefix should be "isil" not "isl". Olof, can you
> please comment here?

> b) There's an interrupt signal connected to the device. Can you please
> add that, irrespective of whether the driver uses it.
>

Will do.
> c) This device is also present on Seaboard. Can you update
> tegra-seaboard.dts too? You can find the relevant bus from the link above.
>
Will do.


I will wait for finalizing the vendor prefix before creating the next patch.
This will impact the driver also.

