Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:49232 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdB0Nqn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 08:46:43 -0500
Subject: Re: [PATCH] staging: iio: ad9834: Moved contents of header file to
 source file
To: Narcisa Vasile <narcisaanamaria12@gmail.com>
References: <1488146361-14383-1-git-send-email-narcisaanamaria12@gmail.com>
 <b587366e-dec9-c550-3617-2a6d76200423@metafoo.de>
 <CAEdesYZkN4+ZXCycyP71FTEKYC750TtPAQMtF62FyYUp+fZCFA@mail.gmail.com>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        jic23@kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <67b0af65-f4cb-5d2f-7018-633accd676dd@metafoo.de>
Date: Mon, 27 Feb 2017 14:46:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAEdesYZkN4+ZXCycyP71FTEKYC750TtPAQMtF62FyYUp+fZCFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/27/2017 02:41 PM, Narcisa Vasile wrote:
> Pe 27 feb. 2017 11:21, "Lars-Peter Clausen" <lars@metafoo.de
> <mailto:lars@metafoo.de>> a scris:
>>
>> On 02/26/2017 10:59 PM, Narcisa Ana Maria Vasile wrote:
>> > The contents of the header file are used only by this single source file
>>
>> Same here, platform data should stay in its the header file, everything else
>> can and should be moved.
>>
>>
> I'm attempting to fix this patch and I want to make sure I understood the
> right way to do it.
> According to the TODO above the platform data struct, this struct should go
> to include/linux/iio. So, is it ok to create a new header file with the
> original name (ad9834.h), place the platform data struct inside it and put
> this header file into include/linux/iio/frequency folder? 
> Then, in the C file, I will include this new header, remove the platform
> data struct, but keep the defines and state struct.
> Same for the other file (ad9832).

Moving this file to the regular include file path will only happen when the
driver as a whole graduates from the staging part of the kernel. For the
time being the file should stay were it is.

So basically the patch is file as it is, except that the platform data
struct should not be moved over to the C file.
