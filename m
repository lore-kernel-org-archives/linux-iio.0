Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:49154 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcFBIhT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 04:37:19 -0400
Subject: Re: [PATCH v2 3/7] iio: adc: ad7793: claim direct mode when writing
 frequency
To: Alison Schofield <amsfield22@gmail.com>, jic23@kernel.org
References: <20160602042802.GA2910@d830.WORKGROUP>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <574FF039.9040909@metafoo.de>
Date: Thu, 2 Jun 2016 10:37:13 +0200
MIME-Version: 1.0
In-Reply-To: <20160602042802.GA2910@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/2016 06:28 AM, Alison Schofield wrote:
> Driver was checking for direct mode and trying to lock it, but
> left a gap where mode could change before the desired operation.
> Use iio_device_claim_direct_mode() to guarantee device stays in
> direct mode.
> 
> Refactor function to clarify look-up followed by lock sequence.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
