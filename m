Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38591 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbbJaK3D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 06:29:03 -0400
Subject: Re: Trying to read data from accelerometer buffer
To: Ibrahim Mattus Neto <ibrahim.neto@gmail.com>,
	linux-iio@vger.kernel.org,
	Paul Cercueil <paul.cercueil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <CAMajgzy7HpEF7vWWJm0tss4BM_ENcJHaqPHJqvrSemZ9tbf7qQ@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <563497ED.5010805@kernel.org>
Date: Sat, 31 Oct 2015 10:29:01 +0000
MIME-Version: 1.0
In-Reply-To: <CAMajgzy7HpEF7vWWJm0tss4BM_ENcJHaqPHJqvrSemZ9tbf7qQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/10/15 10:05, Ibrahim Mattus Neto wrote:
> Hi, I am having issues reading from a accelerometer and I hope yo
> might help me (if I should ask this question elsewhere, please tell
> me)
> 
> What I am trying to do is get data from a buffer (I am using the
> source code from iio_readdev as an example) but I can't figure it out
> how to interpret the data properly.
A quick google suggests this is from libiio.  Perhaps Paul or Lars
can give more detail.
> 
> I was expecting to get a bunch of numbers related to the X axis but
> when it writes to stdout I get a bunch of weird characters, here is
> the output:
> 
> @������@������������������������������������������������
> 
> How can I get values of x, y and z axes?
The data is in binary, whereas piping it to stdout is presumably going to expect
asci characters.   I would imagine, glancing at that example code
that it was meant for piping into some other program that actually interpreted
the stream?

Alternatively, take a look at tools/iio/generic_buffer.c in the kernel source
tree for an example of how to read from the buffers.
> 
> Is there anything else I should provide? Is there some information missing?
> 
> Thanks in advance!
> Ibrahim
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 

