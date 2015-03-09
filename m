Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43265 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbbCINPJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 09:15:09 -0400
Message-ID: <54FD9CD9.3080306@kernel.org>
Date: Mon, 09 Mar 2015 13:15:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: abhijit <abhijitnaik27@gmail.com>, linux-iio@vger.kernel.org,
	Patrick Vasseur <patrick.vasseur@c-s.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: AD7923 sequencer functionality implementation in Kernel
References: <54FD2F9A.2070502@gmail.com>
In-Reply-To: <54FD2F9A.2070502@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/15 05:28, abhijit wrote:
> Hi All,
> 
> We are using AD7923 driver as reference for one of our customer's ADC IP
> 
> The ADC that we are using, has sequencer functionality. In current state of AD7923 driver, there is no support for sequencer functionality.
> 
> Can you please let me know whether the IIO driver team is coming up with design for sequencer functionality of the device.
Cc'd Lars, Michael and Patrick.  Looks like a fairly standard sequencer.
Just a question of whether anyone has already looked at it.

Jonathan
> 
> With Warm Wishes,
>       Abhijit Naik
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

