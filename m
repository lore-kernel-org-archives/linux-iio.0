Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CF4319847;
	Mon,  2 Mar 2026 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486065; cv=none; b=njuhR4LNs50uSCqvgT8x6Kf9aC9xjrZPeKo2SyRRRO6cB75RikHwAKxlgKbGQTtwFviFOxe21xwK1HXd4Tfo3VDTRzF0mk5yrhi9BBG+523b0YvqJy0fX6eUyAU2wzO6xrf8jQDhGIAseHjCauvHQPPfmr7wffVOgETU/q34OuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486065; c=relaxed/simple;
	bh=p8rZoPTDLwf0IXEOuKk5d0TD9WLx1c2nuF4ZJmLbaxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNyet/RiUP0V7gqhy6p1phqe7+d/ivWJxd8fVqbOg3ZyY6wso3vRYe8hEJS8qhP47a24cpIPiJgzZt82uzjOG7e7MtQapXdXCbezMa12DxRD1xntBCXduucweQFLuFqV/xF1LUKig9Bbst7TxJ8U5p8Avtpn/bNfN2Q4NI3afVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEtwKh89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEtwKh89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBC9C19423;
	Mon,  2 Mar 2026 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772486064;
	bh=p8rZoPTDLwf0IXEOuKk5d0TD9WLx1c2nuF4ZJmLbaxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TEtwKh89xilwy0AfIxmJ6o59lo3nikZA4b2h4eTUmLJ+xeQn+1VnduNI83ol3aOux
	 nersnVAd2KSjtGOBG8ZTXZc1ejccqzHVFEN+Nhd5+6pdDrF5e8Ait/jpNJ+5d6zhFk
	 66jq2ywNoIamJHk6onoAKgQCSCPOvQD89JWalHX7hPkw1TvnCY3+Y4FUTMuMLnvrAw
	 ZK5JmOyDlwTzc7TZW9ToECxhpLkidaGFko0W5s/IAbLlnxb9WJGZVfeq78ealZC1q8
	 ax2XrEdVt1Q7ljQoZ94JMo2W7EAImx5u+voSqIgfI/t3AyzFsybxqNa+T3O7i7QvFY
	 /QhGavTzofmHQ==
Date: Mon, 2 Mar 2026 21:14:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bno055: add explicit scan buf layout
Message-ID: <20260302211417.0e4fc10f@jic23-huawei>
In-Reply-To: <20260228-iio-imu-bno055-repeated-element-v2-1-888676158804@baylibre.com>
References: <20260228-iio-imu-bno055-repeated-element-v2-1-888676158804@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 14:15:51 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Move the scan buf.chans array into a union along with a struct that
> gives the layout of the buffer with all channels enabled.
> 
> Although not technically required in this case, if there had been a
> different number of items before the quaternion, there could have been
> a subtle bug with the special alignment needed for the quaternion
> channel data and the array would have been too small.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This depends on [1] that introduces the IIO_DECLARE_QUATERNION()
> macro. I didn't include it in the same series because the other series
> contains a fix and should be backported while this one ins't a fix.
> 
> [1]: https://lore.kernel.org/linux-iio/20260214-iio-fix-repeat-alignment-v1-1-47f01288c803@baylibre.com/
> ---
> Changes in v2:
> - Rename IIO_DECLARE_REPEATED_ELEMENT() to IIO_DECLARE_QUATERNION().
> - Link to v1: https://lore.kernel.org/r/20260214-iio-imu-bno055-repeated-element-v1-1-b57b08efd566@baylibre.com
> ---
>  drivers/iio/imu/bno055/bno055.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
> index 303bc308f80a..d91558e100cc 100644
> --- a/drivers/iio/imu/bno055/bno055.c
> +++ b/drivers/iio/imu/bno055/bno055.c
> @@ -211,7 +211,25 @@ struct bno055_priv {
>  	struct gpio_desc *reset_gpio;
>  	bool sw_reset;
>  	struct {
> -		__le16 chans[BNO055_SCAN_CH_COUNT];
> +		union {
> +			__le16 chans[BNO055_SCAN_CH_COUNT];
> +			/*
> +			 * Struct is to ensure proper size in case any padding
> +			 * is needed. Technically not needed in this case, but
> +			 * better to be explicit about the requirements.
> +			 */
> +			struct {
> +				__le16 acc[3];
> +				__le16 magn[3];
> +				__le16 gyr[3];
> +				__le16 yaw;
> +				__le16 pitch;
> +				__le16 roll;
> +				IIO_DECLARE_QUATERNION(__le16, quaternion);
> +				__le16 lia[3];
> +				__le16 gravity[3];
> +			};
> +		};
>  		aligned_s64 timestamp;
>  	} buf;

It's not a new problem, but I'm not sure a structure is valid here at all
as the driver isn't using avail_scan_masks to enforce all channels are enabled.

If I read it right we can get any subset of those channels.

Generally for these we've been using the macro you added rather than
an explicit structure, but if we do that we don't get the align to 8 of the
quaternion as an explicit thing.  Maybe we make an exception and use
a structure here but if we do should we pull the timestamp into that
struct and use IIO_DECLARE_BUFFER_WITH_TS) for the chans array so
that we make it clear everything floats around depending on what
is in use.

Jonathan




>  	struct dentry *debugfs;
> 
> ---
> base-commit: 0b9f2af96d9dc898af3aa58bd55bf62768229b92
> change-id: 20260214-iio-imu-bno055-repeated-element-1c1552ea74be
> prerequisite-change-id: 20260214-iio-fix-repeat-alignment-575b2c009e25:v2
> prerequisite-patch-id: e155a526d57c5759a2fcfbfca7f544cb419addfd
> prerequisite-patch-id: 6c69eaad0dd2ae69bd2745e7d387f739fc1a9ba0
> 
> Best regards,

