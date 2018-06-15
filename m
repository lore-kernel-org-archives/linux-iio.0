Return-Path: <m.othacehe@gmail.com>
References: <87a7snd8r7.fsf@gmail.com> <876037dc4f.fsf@gmail.com> <20180603153833.0710bc03@archlinux> <87o9gpbkpc.fsf@gmail.com> <20180610142909.278028c5@archlinux> <87wov5id5w.fsf@gmail.com>
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: isl29501 and multiple calibration registers
In-reply-to: <87wov5id5w.fsf@gmail.com>
Date: Fri, 15 Jun 2018 14:34:08 +0200
Message-ID: <87po0si5z3.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>


Hi,

I have another concern about I and Q representation. The formula given
by Renesas to put them under decimal form is:

         (MSB << 8 + LSB) << EXP/100000

Given that EXP is an unsigned 8 bit integer, the maximum value of I and
Q is ~2^255 which can only be represented as a double.

Hence, it is not possible to represent them under in_intensity0_i/q_raw
even using a scale.

Same thing for I and Q calibbias (crosstalk values), the user can not
input such a big number.

How could we proceed about it, would it be ok to represent those values
as EXP << 16 + MSB << 8 + LSB both for raw and calibbias values?

Thanks,

Mathieu
