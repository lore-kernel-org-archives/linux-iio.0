Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:56340 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbcFVIGh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 04:06:37 -0400
Subject: Re: [PATCH v3] iio: temperature: add support for Maxim thermocouple
 chips
To: Jonathan Cameron <jic23@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>
References: <1464572270-29154-1-git-send-email-mranostay@gmail.com>
 <6e79df7d-4ac1-3a44-e303-af858f30e161@kernel.org>
Cc: linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>,
	Matt Porter <mporter@konsulko.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <576A46EB.9040505@metafoo.de>
Date: Wed, 22 Jun 2016 10:06:03 +0200
MIME-Version: 1.0
In-Reply-To: <6e79df7d-4ac1-3a44-e303-af858f30e161@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2016 02:33 PM, Jonathan Cameron wrote:
> On 30/05/16 02:37, Matt Ranostay wrote:
>> Add initial driver support for MAX6675, and MAX31885 thermocouple chips.

Is this a typo? There does not seem to be a MAX31885, only MAX31855.

