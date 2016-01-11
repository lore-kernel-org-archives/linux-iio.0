Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:33951 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944AbcAKT03 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2016 14:26:29 -0500
MIME-Version: 1.0
In-Reply-To: <5694017C.2050507@kernel.org>
References: <1452529385-20940-1-git-send-email-ricardo.ribalda@gmail.com> <5694017C.2050507@kernel.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jan 2016 20:26:08 +0100
Message-ID: <CAPybu_1sOxX9_zr7ujhhXxZvH4=8c5VUU-6kAEiynan_K-x6OA@mail.gmail.com>
Subject: Re: [PATCH v6] iio: add ad5761 DAC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Jonathan

On Mon, Jan 11, 2016 at 8:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 11/01/16 16:23, Ricardo Ribalda Delgado wrote:
>> ad5761 is a 1-channel DAC with configurable output range.
>> The driver uses the regulator interface for its voltage ref.
>>
>> It shares its register layout with ad5761r, ad5721 and ad5721r.
>>
>> Differences:
>> ad5761* are 16 bit, ad5721* are 12 bits.
>> ad57*1r have an internal reference.
>>
>> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Just that unnecessary null check left as far as I'm concerned.
> I'd like to leave this a little while for others to take a look
> if they like as well.

Shall i send v7 with that fixed or I wait?


Regards!
