Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:34150 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeBHRvy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Feb 2018 12:51:54 -0500
Subject: Re: Best practices for sending digital data
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Pavel Roskin <plroskin@gmail.com>
Cc: linux-iio@vger.kernel.org
References: <CAN_72e2eEoLKNUqte=xmUCyLj6L+asJVL9k_rqXGJd1ky7v=Cw@mail.gmail.com>
 <20180208101837.00001c55@huawei.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <df0652c1-80cf-bf69-252d-0859a7cff7c8@metafoo.de>
Date: Thu, 8 Feb 2018 18:51:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180208101837.00001c55@huawei.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/2018 11:18 AM, Jonathan Cameron wrote:
> On Wed, 7 Feb 2018 14:15:30 -0800
> Pavel Roskin <plroskin@gmail.com> wrote:>>
>> I understand that the IIO layer tries to be helpful with
>> standardization, but I believe it's too restrictive.
>>
> So the question is what is the alternative to adding new channel types
> when they are needed?
> 
[...]
> 2) We add magic 'user defined types'.  The problem then is that
>    the primary purpose of not just throwing all the drivers in with
>    their own interfaces is gone.  There is no standardization at all and
>    every device needs it's own userspace code.

Just want to add that this is a 'misc' device and this option is still on
the table. If you think the standard IIO ABI is too restrictive and you'd
rather have a device specific ABI you can write a misc driver for your
device. Or directly write a userspace driver.

The preferred solution of course is to work with the IIO framework and come
up with solutions for the shortcomings.
