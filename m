Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:10108 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbcCJAHr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2016 19:07:47 -0500
Subject: Re: [PATCH v6 0/1] iio:pressure:ms5611: fix and enhancements
To: Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1457522751.git.gregor.boirie@parrot.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56E0BAC8.2080607@samsung.com>
Date: Thu, 10 Mar 2016 09:07:36 +0900
MIME-version: 1.0
In-reply-to: <cover.1457522751.git.gregor.boirie@parrot.com>
Content-type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09.03.2016 20:34, Gregor Boirie wrote:
> Changes since v1:
> * temperature compensation fix:
>     * reword commit message
>     * remove useless parenthesis
> * power regulator: reword commit message
> * add oversampling rate support
> 
> Changes since v2:
> * remove non printable characters from commit messages
> 
> Changes since v3:
> * drop first 3 patches since applied onto testing
> * fix oops at regulator probing time if regulator support not compiled-in
> * complete device-tree support and documentation
> * remove continuous sampling support (see Jonathan's "kthread tight loop
>   trigger" proposal)
> * checkpatch'ed
> 
> Changes since v4:
> * drop first 2 patches since applied
> * amend commit to include "Fixes" tag
> 
> Changes since v5:
> * reword patch subject line and include "Fixes" tag in commit message
> 
> Gregor Boirie (1):
>   iio:pressure:ms5611: fix crash when probing regulator
> 
>  drivers/iio/pressure/ms5611_core.c | 8 ++++++--

Really, how the heck you connected my humble person with this file?
get_maintainer.pl does not print me. Even when run with --git argument.

BR,
Krzysztof


