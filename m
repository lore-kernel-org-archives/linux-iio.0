Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45493 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbHBRmF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:42:05 -0400
Subject: Re: [PATCH] tools: iio: remove unnecessary define guard from
 iio_utils.c
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Joo Aun Saw <jasaw@dius.com.au>
References: <1438005278-3439-1-git-send-email-jasaw@dius.com.au>
 <CAEnQRZD_Ogq+wDeTidcJaszD+o0_v-G4dMEaQhxT5Rk0PZqEKw@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE566B.8030606@kernel.org>
Date: Sun, 2 Aug 2015 18:42:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZD_Ogq+wDeTidcJaszD+o0_v-G4dMEaQhxT5Rk0PZqEKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/15 15:15, Daniel Baluta wrote:
> On Mon, Jul 27, 2015 at 4:54 PM, Joo Aun Saw <jasaw@dius.com.au> wrote:
>> From: Joo Aun Saw <jasaw@dius.com.au>
>>
>> _IIO_UTILS_H_ define guard is unnecessary in iio_utils.c
>>
>> Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
> 
> Preferred way for the commit message subject is:
> 
> tools: iio: iio_utils: remove unnecessary define guard
> 
> Other than that it looks good to me.
> 
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to ignore it.

Thanks,

Jonathan
