Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from exchange.essensium.com ([81.246.79.137]:31084 "EHLO
	exchange.essensium.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbCITf5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 15:35:57 -0400
Date: Mon, 9 Mar 2015 20:35:29 +0100
From: Vianney le =?iso-8859-1?q?Cl=E9ment?=
	<vianney.leclement@essensium.com>
Subject: Re: [PATCH 4/7] iio: mlx90614: Support devices with dual IR sensor
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Message-ID: <1425929729.5817.4@mail.essensium.com>
In-Reply-To: <54FDB9CE.2060104@kernel.org>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
	<1424879712-28304-5-git-send-email-vianney.leclement@essensium.com>
	<54FDB9CE.2060104@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 9, 2015 at 4:18 , Jonathan Cameron <jic23@kernel.org> wrote:
> On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
>>  The model is detected by reading the EEPROM configuration during
>>  probing.  In the dual IR sensor model, the ambient temperature is
>>  exported twice to userspace.  This makes the two channels appear
>>  completely symmetrical.
> Why do we want it to be symmetrical?

Well, except for the beauty of symmetry, I do not have any hard 
argument, nor do I have any strong feelings about it :).  I can leave 
the duplicate out in v2.

> Is there a part number difference for the dual sensor version?  If so 
> we can still
> autoprobe for it, but want to make sure we have it listed as a 
> supported part.

Nope.  The only difference lies in the option code: 
MLX90614ESF-BAA-000-TU is single-zone, while MLX90614ESF-BBA-000-TU is 
dual (notice the second letter in the second group).

>>  +/* Return 0 for single sensor, 1 for dual sensor, <0 on error. */
>>  +static int mlx90614_probe_model(struct i2c_client *client)
> I'd give this a more specific name.  probe_num_ir_sensors or similar.

Will be changed in v2.

Vianney

