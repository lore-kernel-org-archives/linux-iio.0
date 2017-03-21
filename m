Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40801 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757240AbdCUTeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 15:34:19 -0400
Subject: Re: [PATCH v2 0/2] Remove Typedefs.
To: Arushi Singhal <arushisinghal19971997@gmail.com>,
        linux-fbdev@vger.kernel.org
References: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <52786ce4-e783-0ea4-c6cb-1deb63e91b53@kernel.org>
Date: Tue, 21 Mar 2017 19:34:12 +0000
MIME-Version: 1.0
In-Reply-To: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/03/17 15:06, Arushi Singhal wrote:
> Typedefs are removed in sm750fb driver.
> 
> Arushi Singhal (2):
>   staging: sm750fb: Remove typedef from "typedef struct _mode_parameter_t"
>   staging: sm750fb: Remove typedef from "typedef enum _spolarity_t"
> 
>  drivers/staging/sm750fb/ddk750_mode.c |  8 +++++---
>  drivers/staging/sm750fb/ddk750_mode.h | 19 ++++++++-----------
>  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
Please be careful to only cc linux-iio for patches with an IIO component...
