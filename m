Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33331 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932597AbbLTLZP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Dec 2015 06:25:15 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1512191736230.3182@pmeerw.net>
References: <1450272464-13992-1-git-send-email-ricardo.ribalda@gmail.com> <alpine.DEB.2.02.1512191736230.3182@pmeerw.net>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Sun, 20 Dec 2015 12:24:54 +0100
Message-ID: <CAPybu_153gi5-gq=3Sh8JLpTxTireTw5Q4rnmpdPqYZNUX2BNQ@mail.gmail.com>
Subject: Re: [PATCH] iio: add ad5761 DAC driver
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Peter:


Thanks for your review! I agree on all your points but one:

On Sat, Dec 19, 2015 at 6:06 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),   \
>> +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |  \
>> +             BIT(IIO_CHAN_INFO_OFFSET),              \
>> +     .scan_type = {                                  \
>
> the driver does not support buffered mode, not sure if scan_type should be
> used to store the number of bits; I think it would be cleaner to put this
> in chip_info


Although I understand your point, must of the other dac drivers are
doing the same and in my humble opinion is very elegant.



Best regards!
