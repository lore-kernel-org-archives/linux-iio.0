Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-173.synserver.de ([212.40.185.173]:1079 "EHLO
	smtp-out-173.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbbCXQC2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2015 12:02:28 -0400
Message-ID: <55118A93.5050202@metafoo.de>
Date: Tue, 24 Mar 2015 17:02:27 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: =?UTF-8?B?Vmlhbm5leSBsZSBDbMOpbWVudCBkZSBTYWludC1NYXJjcQ==?=
	<vianney.leclement@essensium.com>, linux-iio@vger.kernel.org
CC: "Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: Re: [PATCH v2 4/7] iio: core: Introduce IIO_CHAN_INFO_EMISSIVITY
References: <1427212459-31585-1-git-send-email-vianney.leclement@essensium.com> <1427212459-31585-5-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427212459-31585-5-git-send-email-vianney.leclement@essensium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/24/2015 04:54 PM, Vianney le Clément de Saint-Marcq wrote:
> Contact-less IR temperature sensors measure the temperature of an object
> by using its thermal radiation.  Surfaces with different emissivity
> ratios emit different amounts of energy at the same temperature.
>
> IIO_CHAN_INFO_EMISSIVITY allows the user to inform the sensor of the
> emissivity of the object in front of it, in order to effectively measure
> its temperature.

All the other attributes that need to be setup according to the object being 
measured start with the calib prefix. So maybe call this calibemissivity.

- Lars
