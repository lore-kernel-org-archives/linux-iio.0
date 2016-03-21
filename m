Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36199 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbcCUTgd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2016 15:36:33 -0400
Subject: Re: [PATCH 1/3] iio: imu: mpu6050: Fix name/chip_id when using ACPI
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
 <1458232366-12773-2-git-send-email-daniel.baluta@intel.com>
 <CAKzfze-nFeMJhp7oRrKaCuM+CRJpokFevCEdxB1Mu96H+pUT6A@mail.gmail.com>
 <56EE7E34.8040608@kernel.org>
 <CAEnQRZCb6qY+XPKyoOjatQ44c65BfGsRo3HU4ozRRMzhx=HXXw@mail.gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Crt Mori <cmo@melexis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Ge Gao <ggao@invensense.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Adriana Reus <adi.reus@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F04466.6010804@kernel.org>
Date: Mon, 21 Mar 2016 18:58:46 +0000
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCb6qY+XPKyoOjatQ44c65BfGsRo3HU4ozRRMzhx=HXXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/03/16 10:16, Daniel Baluta wrote:
> On Sun, Mar 20, 2016 at 12:40 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 17/03/16 17:21, Matt Ranostay wrote:
>>> Reviewed-By: Matt Ranostay <matt.ranostay@intel.com>
>> I'm guessing this may at some point want backporting, but right now it only
>> applies to my togreg branch (due to prior changes) so that's where I've applied
>> this.  If you want a faster path to mainline, the please send me the backport.
> 
> Sure. One thing: on which branch should I rebase the changes?
> 
> fixes or fixes-togreg?
Doh, fixes was a mistype at somepoint.  Now gone from backend, should
clear off front end shortly.

Jonathan
> 
> Daniel.
> 

