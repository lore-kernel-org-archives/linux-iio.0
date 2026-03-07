Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FAF32E6BD;
	Sat,  7 Mar 2026 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903088; cv=none; b=pOrUSNawwjks9W6npbKYgtIKbGwN7V57AW8iAuLiYHgD17m4SpxCDmxVBiG+kepxoNP2dWUx4/zWt4QJs5ZQ+v/LHjV9iQsNIioEfCUzJqqHscBtVA94oKsQYQwp1sItPEdyCnCKe93fpVm1ey6QxXHKoL3BIeUNVrZ4u2erFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903088; c=relaxed/simple;
	bh=5380by2CPUIVMzJR7u9DfCB11cNiuvH6hg1JKoKLHSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VYZkeg3EAw081EaOj/SLq8vhNxXZD7EyJoqVXL2jipdMADSqyYZep+Ye6dJbE1W3Jl04MeDLuuIz/kTnc3uYwCKEEcZXeW6cz1Q5nWwO76bJlu6RFOotDQxWMmC8MnNiu1U+rMJlKQYFk1RuvOkfUeMmttCUyGHUKS/7fMj1YHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKKSE9gm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKKSE9gm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D566C19422;
	Sat,  7 Mar 2026 17:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772903088;
	bh=5380by2CPUIVMzJR7u9DfCB11cNiuvH6hg1JKoKLHSE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jKKSE9gms3nGJFLTdZcsxLfsMhQ91Bv6AF3XDErsOJKE3WymGGQYlJ0EuNcwVBX7L
	 cfAjvIqsnCO5sIKb/KOWWppbrZiVi5MLK63HHeYJDWCVwIb2iOoumbqkzlOZ8gyEOk
	 F/aCc1eYSdICsrIjj9xvegwjXUYqmjLR7ya930itlBSgHFhAZ//WCr7dhAM5ntM3zV
	 FSSLohTKKckfmfne2RNSYmBy7AJ7biRHM7jByDwo/qWv8leqVN/TxDHzhLsNymWhCD
	 aGBLegSbz/j+A1UfdR7uEEZROlQ2LF4nV03+shwuEH9xPgcAvyLSoZ8snt9qS+qbW1
	 4wl+2cxvQl49w==
Date: Sat, 7 Mar 2026 17:04:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <20260307170439.6c64be73@jic23-huawei>
In-Reply-To: <aaxC9T75dtLR-AD8@lore-desk>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	<20260304080600.2844267-1-flavra@baylibre.com>
	<20260307124629.7b4c3953@jic23-huawei>
	<aaxC9T75dtLR-AD8@lore-desk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Mar 2026 16:23:33 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Wed,  4 Mar 2026 09:06:00 +0100
> > Francesco Lavra <flavra@baylibre.com> wrote:
> >   
> > > The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> > > accelerometer invalid samples (i.e. samples that have been acquired during
> > > the settling time of sensor filters) with the special values 0x7FFFh,
> > > 0x7FFE, and 0x7FFD.
> > > The driver checks FIFO samples against these special values in order to
> > > discard invalid samples; however, it does the check regardless of the type
> > > of samples being processed, whereas this feature is specific to gyroscope
> > > and accelerometer data. This could cause valid samples to be discarded.
> > > 
> > > Fix the above check so that it takes into account the type of samples being
> > > processed. To avoid casting to __le16 * when checking sample values, clean
> > > up the type representation for data read from the FIFO.
> > > 
> > > Fixes: 960506ed2c69 ("iio: imu: st_lsm6dsx: enable drdy-mask if available")
> > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>  
> > Looks fine to me, but looking for a Lorenzo tag ideally given it's not
> > a particularly trivial fix!
> > 
> > Jonathan  
> 
> Hi Francesco,
> 
> thx for fixing this, I think the patch is fine, just a couple of nits inline if
> you need to repost.
> 
> Regards,
> Lorenzo
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> > > ---
> > >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 +++++++++++--------
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index 5b28a3ffcc3d..a6ee2da5a06c 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > @@ -365,8 +365,6 @@ static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
> > >  	return 0;
> > >  }
> > >  
> > > -#define ST_LSM6DSX_IIO_BUFF_SIZE	(ALIGN(ST_LSM6DSX_SAMPLE_SIZE, \
> > > -					       sizeof(s64)) + sizeof(s64))
> > >  /**
> > >   * st_lsm6dsx_read_fifo() - hw FIFO read routine
> > >   * @hw: Pointer to instance of struct st_lsm6dsx_hw.
> > > @@ -539,14 +537,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
> > >  #define ST_LSM6DSX_INVALID_SAMPLE	0x7ffd
> > >  static int
> > >  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > > -			    u8 *data, s64 ts)
> > > +			    __le16 *data, s64 ts)
> > >  {
> > > -	s16 val = le16_to_cpu(*(__le16 *)data);
> > >  	struct st_lsm6dsx_sensor *sensor;
> > >  	struct iio_dev *iio_dev;
> > >  
> > >  	/* invalid sample during bootstrap phase */
> > > -	if (val >= ST_LSM6DSX_INVALID_SAMPLE)
> > > +	if ((tag == ST_LSM6DSX_GYRO_TAG || tag == ST_LSM6DSX_ACC_TAG) &&
> > > +	    (s16)le16_to_cpup(data) >= ST_LSM6DSX_INVALID_SAMPLE)
> > >  		return -EINVAL;  
> 
> what about moving this check to a dedicated routine? Like
> st_lsm6dsx_check_data() or similar?

Make sense. Let's do that as part of this fix.

> 
> > >  
> > >  	/*
> > > @@ -609,7 +607,13 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> > >  	 * must be passed a buffer that is aligned to 8 bytes so
> > >  	 * as to allow insertion of a naturally aligned timestamp.
> > >  	 */
> > > -	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
> > > +	struct {
> > > +		union {
> > > +			__le16 data[3];
> > > +			__le32 fifo_ts;
> > > +		};
> > > +		aligned_s64 timestamp;
> > > +	} iio_buff = { };  
> 
> you can get rid of space between brackets.

Prefer not on this.  I'm trying to standardize on having the space as it looks
more normal in some other usecases than no space.  I had to a pick a style and
this is the one I went with a year or so back.

> 
> > >  	u8 tag;
> > >  	bool reset_ts = false;
> > >  	int i, err, read_len;
> > > @@ -648,7 +652,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> > >  
> > >  		for (i = 0; i < pattern_len;
> > >  		     i += ST_LSM6DSX_TAGGED_SAMPLE_SIZE) {
> > > -			memcpy(iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
> > > +			memcpy(&iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
> > >  			       ST_LSM6DSX_SAMPLE_SIZE);
> > >  
> > >  			tag = hw->buff[i] >> 3;
> > > @@ -659,7 +663,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> > >  				 * B0 = ts[7:0], B1 = ts[15:8], B2 = ts[23:16],
> > >  				 * B3 = ts[31:24]
> > >  				 */
> > > -				ts = le32_to_cpu(*((__le32 *)iio_buff));
> > > +				ts = le32_to_cpu(iio_buff.fifo_ts);
> > >  				/*
> > >  				 * check if hw timestamp engine is going to
> > >  				 * reset (the sensor generates an interrupt
> > > @@ -670,7 +674,8 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> > >  					reset_ts = true;
> > >  				ts *= hw->ts_gain;
> > >  			} else {
> > > -				st_lsm6dsx_push_tagged_data(hw, tag, iio_buff,
> > > +				st_lsm6dsx_push_tagged_data(hw, tag,
> > > +							    iio_buff.data,
> > >  							    ts);
> > >  			}
> > >  		}  
> >   

