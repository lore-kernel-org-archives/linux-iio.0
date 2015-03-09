Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from exchange.essensium.com ([81.246.79.137]:31791 "EHLO
	exchange.essensium.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbCITnv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 15:43:51 -0400
Date: Mon, 9 Mar 2015 20:27:39 +0100
From: Vianney le =?iso-8859-1?q?Cl=E9ment?=
	<vianney.leclement@essensium.com>
Subject: Re: [PATCH 3/7] iio: mlx90614: Add processed temperature output
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Message-ID: <1425929259.5817.3@mail.essensium.com>
In-Reply-To: <54FDB788.3050009@kernel.org>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
	<1424879712-28304-4-git-send-email-vianney.leclement@essensium.com>
	<54FDB788.3050009@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 9, 2015 at 4:08 , Jonathan Cameron <jic23@kernel.org> wrote:
> On 25/02/15 15:55, Vianney le Clément de Saint-Marcq wrote:
>>  Provide processed temperature in milli-Celsius through the
>>  in_temp_*_input interface.
> Why?  It's trivial for userspace to do the conversion, so
> why provide the additional interface?  As a rule we don't provide
> both as in general these sensors are wrapped up in a library that can
> do the work more efficiently in userspace when needed.

Many thanks for reviewing this series, Jonathan.

I was not aware of this rule.  I will remove this patch from v2 (except 
for the tiny comment fix).

Vianney

