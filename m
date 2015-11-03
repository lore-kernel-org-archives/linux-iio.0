Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33292 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbbKCLT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2015 06:19:56 -0500
Received: by obbwb3 with SMTP id wb3so9703308obb.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2015 03:19:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563497ED.5010805@kernel.org>
References: <CAMajgzy7HpEF7vWWJm0tss4BM_ENcJHaqPHJqvrSemZ9tbf7qQ@mail.gmail.com>
	<563497ED.5010805@kernel.org>
Date: Tue, 3 Nov 2015 09:19:55 -0200
Message-ID: <CAMajgzw3VZ7oKiP5+_Rp7CVTREfOKAD2WicRLb+KC_Y1CWuimg@mail.gmail.com>
Subject: Re: Trying to read data from accelerometer buffer
From: Ibrahim Mattus Neto <ibrahim.neto@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Paul Cercueil <paul.cercueil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Thank you for your time!

I read through libiio documentation and found what I was missing. It
was a matter of using 'iio_channel_convert'

Here is how I managed to get the data.

I used as a guide the file iio_readdev.c and changed the print_sample
function to:

static ssize_t print_sample(const struct iio_channel *chn, void *buf,
size_t len, void * d) {
/* Function called for each sample on buffer*/
    int16_t val;

    iio_channel_convert(chn, &val, buf);

    printf("Value of sample: %d", val);

    fflush(stdout);

    return len;
}

Thank you very much for your help!

Regards,
Ibrahim.

2015-10-31 8:29 GMT-02:00 Jonathan Cameron <jic23@kernel.org>:
> On 29/10/15 10:05, Ibrahim Mattus Neto wrote:
>> Hi, I am having issues reading from a accelerometer and I hope yo
>> might help me (if I should ask this question elsewhere, please tell
>> me)
>>
>> What I am trying to do is get data from a buffer (I am using the
>> source code from iio_readdev as an example) but I can't figure it out
>> how to interpret the data properly.
> A quick google suggests this is from libiio.  Perhaps Paul or Lars
> can give more detail.
>>
>> I was expecting to get a bunch of numbers related to the X axis but
>> when it writes to stdout I get a bunch of weird characters, here is
>> the output:
>>
>> @������@������������������������������������������������
>>
>> How can I get values of x, y and z axes?
> The data is in binary, whereas piping it to stdout is presumably going to expect
> asci characters.   I would imagine, glancing at that example code
> that it was meant for piping into some other program that actually interpreted
> the stream?
>
> Alternatively, take a look at tools/iio/generic_buffer.c in the kernel source
> tree for an example of how to read from the buffers.
>>
>> Is there anything else I should provide? Is there some information missing?
>>
>> Thanks in advance!
>> Ibrahim
>> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z� ��h����&�� �G���h� (�階�ݢj"�� � m�����z�ޖ���f���h���~�mml==
>>
>
