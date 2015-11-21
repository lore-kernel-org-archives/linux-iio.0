Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-100.synserver.de ([212.40.185.100]:1063 "EHLO
	smtp-out-188.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751780AbbKUS2a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2015 13:28:30 -0500
Message-ID: <5650B7C9.5020809@metafoo.de>
Date: Sat, 21 Nov 2015 19:28:25 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: cristina.opriceana@gmail.com
Subject: Re: [PATCH] staging:iio: Delete some commented out lines in Kconfig.
References: <1448130164-29097-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1448130164-29097-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/21/2015 07:22 PM, Jonathan Cameron wrote:
> These should have been removed with the driver move out of staging
> but instead were commented out.  This was missed in reviews at the
> time so fixing it up now.

The Makefile has the same issue. Sorry, saw that only after sending the
initial mail.
