Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41067 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbKUUOK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2015 15:14:10 -0500
Subject: Re: [PATCH] staging:iio: Delete some commented out lines in Kconfig.
To: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <1448130164-29097-1-git-send-email-jic23@kernel.org>
 <5650B7C9.5020809@metafoo.de>
Cc: cristina.opriceana@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5650D08E.6040105@kernel.org>
Date: Sat, 21 Nov 2015 20:14:06 +0000
MIME-Version: 1.0
In-Reply-To: <5650B7C9.5020809@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/11/15 18:28, Lars-Peter Clausen wrote:
> On 11/21/2015 07:22 PM, Jonathan Cameron wrote:
>> These should have been removed with the driver move out of staging
>> but instead were commented out.  This was missed in reviews at the
>> time so fixing it up now.
> 
> The Makefile has the same issue. Sorry, saw that only after sending the
> initial mail.
Doh! I should have checked.  Will fix that up and resend.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

