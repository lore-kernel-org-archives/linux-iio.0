Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35841 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbbFAVRH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:07 -0400
Message-ID: <556C3290.3040605@kernel.org>
Date: Mon, 01 Jun 2015 11:23:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>,
	sudipm.mukherjee@gmail.com, daniel.baluta@intel.com,
	dan.carpenter@oracle.com, gregkh@linuxfoundation.org
CC: cristina.opriceana@gmail.com,
	driverdev-devel@linuxdriverproject.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/3] staging: iio_simple_dummy: fix module_param type
References: <1432974017-24547-1-git-send-email-rodriguez.twister@gmail.com> <1432974017-24547-4-git-send-email-rodriguez.twister@gmail.com>
In-Reply-To: <1432974017-24547-4-git-send-email-rodriguez.twister@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/05/15 09:20, Vladimirs Ambrosovs wrote:
> Fix the module_param "instances" type to uint, since the variable type
> holding the value is unsigned.
> 
> Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Applied to the togreg branch of iio.git - which will get pushed
out as testing in a few days. Or just possibly tonight if the hotel
network is working well and I can remember my password :)

Jonathan
> ---
>  drivers/staging/iio/iio_simple_dummy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index dc9482c7..1629a8a 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -30,7 +30,7 @@
>   * dummy devices are registered.
>   */
>  static unsigned instances = 1;
> -module_param(instances, int, 0);
> +module_param(instances, uint, 0);
>  
>  /* Pointer array used to fake bus elements */
>  static struct iio_dev **iio_dummy_devs;
> 

