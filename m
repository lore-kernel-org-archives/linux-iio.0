Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57799 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbaJDLtr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 07:49:47 -0400
Message-ID: <542FDED8.50000@kernel.org>
Date: Sat, 04 Oct 2014 12:49:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Darshana Padmadas <darshanapadmadas@gmail.com>,
	opw-kernel@googlegroups.com
CC: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v3 0/4] Correct vendor-prefix and document device isl29028
References: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Please repost this series with the device tree list and maintainers cc'd.
What you have looks fine to me, but as it is effecting bindings they must
have the opportunity to comment. Rules are either an Ack from them or
a least 3 weeks on their list then I can make up my own mind :)

On 30/09/14 12:59, Darshana Padmadas wrote:
> Patchset documents correct and the deprecated vendor-prefix found by checkpatch 
> warning and also documents information of device isl29028 for compatibility. 
> Patchset also includes corrected vendor-prefix and device name in compatible 
> property for files with checkpatch warning of undocumented string "isil,isl29028".
> 
> Darshana Padmadas (4):
>   Documentation: devicetree: bindings: Document correct and deprecated
>     vendor-prefix with device isl29028
>   Documentation: devicetree: bindings: Document deprecated device vendor
>     name to fix related warning
>   Staging: iio: light: Added correct vendor-prefix for device isl29028
>   arch: arm: boot: dts: Added correct vendor-prefix with device name to
>     compatible property
>   
> Changes in v3:
>     - In PATCH 1/4 corrected alphabetical order of vendor-prefix and device name.
>     - In PATCH 2/4 inserted deprecated vendor-prefix in list in alphabetical order
>       and edited vendor/chip string.
>     - In PATCH 4/4 dropped deprecated string "isil,isl29028" and included correct 
>       vendor-prefix isl with isl29028 to give "isl,isl29028" for device's compatible
>       property.
> 
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
>  Documentation/devicetree/bindings/vendor-prefixes.txt     | 1 +
>  drivers/staging/iio/light/isl29028.c                      | 3 ++-
>  arch/arm/boot/dts/tegra30-cardhu.dtsi                     | 2 +-
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
