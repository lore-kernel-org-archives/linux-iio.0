Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42529 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbDZSpm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:45:42 -0400
Message-ID: <553D3254.7030502@kernel.org>
Date: Sun, 26 Apr 2015 19:45:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 05/17] iio: accel: mma9551_core: wrong doc fixes
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-6-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-6-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> Fix docummentation for mma9553_read_* functions.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git. Initially pushed
out as testing for the autobuilders to play with it.

Jonathan
> ---
>  drivers/iio/accel/mma9551_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index c6d5a3a..efe09a3 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -374,7 +374,7 @@ EXPORT_SYMBOL(mma9551_read_status_word);
>   * @app_id:	Application ID
>   * @reg:	Application register
>   * @len:	Length of array to read in bytes
> - * @val:	Array of words to read
> + * @buf:	Array of words to read
>   *
>   * Read multiple configuration registers (word-sized registers).
>   *
> @@ -414,7 +414,7 @@ EXPORT_SYMBOL(mma9551_read_config_words);
>   * @app_id:	Application ID
>   * @reg:	Application register
>   * @len:	Length of array to read in bytes
> - * @val:	Array of words to read
> + * @buf:	Array of words to read
>   *
>   * Read multiple status registers (word-sized registers).
>   *
> @@ -454,7 +454,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
>   * @app_id:	Application ID
>   * @reg:	Application register
>   * @len:	Length of array to write in bytes
> - * @val:	Array of words to write
> + * @buf:	Array of words to write
>   *
>   * Write multiple configuration registers (word-sized registers).
>   *
> 

