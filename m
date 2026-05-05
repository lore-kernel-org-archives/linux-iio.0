Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558DF492181;
	Tue,  5 May 2026 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999149; cv=none; b=cAEVdTYJDDHouk5PDqsFh/vrJYw6NZ/lOBpqN2XfgECM4T79Oo3TfgTDT0qE504fGGRyx/vtUk8p8xG2ZT9TlaI2bTAJu44kk/gMIPaFUsganN1U8zOfdWLbFiBpwjyOwYMN9MfOAOREBoCWhQ7Z7EgopEQs1uacKknEIfqEn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999149; c=relaxed/simple;
	bh=5CQrIvt3CzHacIzhOLvkWJqVxGuQ3FepbgPqsepnjks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oK3d9buxadBP2xMDuVH6br6EOp0VtzEO9upi2mBxX10mCMBDb3+DjzSPg0BOZVkqoVKTX7cfXB25lf/vlRWzqM72lhxuHoy4PDZw+9W3Ru5/L1cx3LwNyDngfi070SZQKACsfMBnZUl3Hew1NPLGZ64D/75h7uu415fnGJpY0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb04ZHFM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb04ZHFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849F5C2BCB4;
	Tue,  5 May 2026 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777999148;
	bh=5CQrIvt3CzHacIzhOLvkWJqVxGuQ3FepbgPqsepnjks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cb04ZHFM53lMIPqErnVdkiuvCiaqIRE0WqNIg/94OiZGwg61Xj+0QoCnI59RzkkJq
	 97SodGnUrUYkiZhDfLJurHjlApt/VdUJOc695EAfO/zmNLiOpD4a9cXp/rIP+xwZMj
	 i1FW10iWJguMrPtWTFAxWEtLyUTxoqgP+63lDtXhBkKHgyILiY3q06pQM0RQFQ80lX
	 9hHvUYqxlR6vRJIBnu7ExbbObrCVsTUgaYUqFCCbisyA7+KpGkzfrU3S9PMs5Qv9Fg
	 g5YnEt/osBCW7A2nMh1Pc5XogtFdpP+rBEeJ8lfMUfMMFv4LQAm5cPAoiKfheGgO13
	 9kYh+p4RlKeow==
Date: Tue, 5 May 2026 17:38:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/9] iio: ssp_sensors: factor out pending list
 add/remove helper(s)
Message-ID: <20260505173859.19b79034@jic23-huawei>
In-Reply-To: <F6B75893-D8A8-4072-BB26-83F630805700@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-3-sanjayembedded@gmail.com>
	<20260426150830.7ab41ad3@jic23-huawei>
	<F6B75893-D8A8-4072-BB26-83F630805700@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 03 May 2026 16:53:27 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> On 26 April 2026 7:38:30=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >On Sun, 26 Apr 2026 14:47:03 +0530
> >Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> > =20
> >> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >>=20
> >> The SSP SPI transfer path manipulates the pending message list in
> >> multiple places, each time open-coding the same locking and list
> >> operations.
> >>=20
> >> Re-factor the pending list add and delete logic into small helper
> >> functions and drop use_no_irq variable to avoid duplication and
> >> simplify transfer flow to follow.
> >>=20
> >> No functional change intended.
> >>=20
> >> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> >> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> ---
> >> Changes in v7:
> >> - Following suggestion from Andy, keep helper API definition in single
> >>   line and re-place the comment section
> >> - v6 change: https://lore.kernel.org/all/20260415050749.3858046-4-sanj=
ayembedded@gmail.com/
> >> Changes in v6:
> >> - Include tag for the suggestion of helper functions
> >> - Drop completely use_no_irq variable with review comment from Andy
> >> - v5 change: https://lore.kernel.org/all/20260406080852.2727453-4-sanj=
ayembedded@gmail.com/
> >> ---
> >>  drivers/iio/common/ssp_sensors/ssp_spi.c | 58 ++++++++++++++----------
> >>  1 file changed, 33 insertions(+), 25 deletions(-)
> >>=20
> >> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/co=
mmon/ssp_sensors/ssp_spi.c
> >> index 08ed92859be0..870214551f0b 100644
> >> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> >> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> >> @@ -174,15 +174,35 @@ static int ssp_check_lines(struct ssp_data *data=
, bool state)
> >>  	return 0;
> >>  }
> >> =20
> >> +static inline void ssp_pending_add(struct ssp_data *data, struct ssp_=
msg *msg)
> >> +{
> >> +	/*
> >> +	 * Check if this is a short one way message or the whole transfer has
> >> +	 * second part after an interrupt.
> >> +	 */
> >> +	if (msg->length =3D=3D 0)
> >> +		return; =20
> >
> >I know Andy suggested your bring these into the helpers, but to me
> >it's obscuring flow as it looks at the caller like it was added
> >to the pending list when it wasn't..  And we end up with multiple
> >checks on msg_length where we had one before.
> >
> >One option would be to have it return a bool to indicate whether
> >it was added to the pending list or not.
> >
> >Andy, would that work for you?
> > =20
> >> +
> >> +	mutex_lock(&data->pending_lock);
> >> +	list_add_tail(&msg->list, &data->pending_list);
> >> +	mutex_unlock(&data->pending_lock);
> >> +}
> >> +
> >> +static inline void ssp_pending_del(struct ssp_data *data, struct ssp_=
msg *msg)
> >> +{
> >> +	/* See ssp_pending_add() for transfer length logic */
> >> +	if (msg->length =3D=3D 0) =20
> >Not useful to know if this happened at caller, so no need to return
> >bool from this. =20
> >> +		return;
> >> +
> >> +	mutex_lock(&data->pending_lock);
> >> +	list_del(&msg->list);
> >> +	mutex_unlock(&data->pending_lock);
> >> +}
> >> +
> >>  static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
> >>  			   struct completion *done, int timeout)
> >>  {
> >>  	int status;
> >> -	/*
> >> -	 * check if this is a short one way message or the whole transfer has
> >> -	 * second part after an interrupt
> >> -	 */
> >> -	const bool use_no_irq =3D msg->length =3D=3D 0;
> >> =20
> >>  	if (data->shut_down)
> >>  		return -EPERM;
> >> @@ -202,35 +222,23 @@ static int ssp_do_transfer(struct ssp_data *data=
, struct ssp_msg *msg,
> >>  		goto _error_locked;
> >>  	}
> >> =20
> >> -	if (!use_no_irq) {
> >> -		mutex_lock(&data->pending_lock);
> >> -		list_add_tail(&msg->list, &data->pending_list);
> >> -		mutex_unlock(&data->pending_lock);
> >> -	}
> >> +	ssp_pending_add(data, msg); =20
> >
> >With suggestion above this would become
> > =20
> Thank you for the input.
> Agree will include in next series.
>=20
> >	use_irq =3D ssp_pending_add(data, msg); =20
> >> =20
> >>  	status =3D ssp_check_lines(data, true);
> >>  	if (status < 0) {
> >> -		if (!use_no_irq) {
> >> -			mutex_lock(&data->pending_lock);
> >> -			list_del(&msg->list);
> >> -			mutex_unlock(&data->pending_lock);
> >> -		}
> >> +		ssp_pending_del(data, msg);
> >>  		goto _error_locked;
> >>  	}
> >> =20
> >>  	mutex_unlock(&data->comm_lock);
> >> =20
> >> -	if (!use_no_irq && done)
> >> -		if (wait_for_completion_timeout(done,
> >> -						msecs_to_jiffies(timeout)) =3D=3D
> >> -		    0) {
> >> -			mutex_lock(&data->pending_lock);
> >> -			list_del(&msg->list);
> >> -			mutex_unlock(&data->pending_lock);
> >> +	if (msg->length && done && =20
> >then
> >	if (use_irq && done &&
> >	    !wait_for_completion_timeout() =20
> >> +	    !wait_for_completion_timeout(done, msecs_to_jiffies(timeout))) {
> >> +		ssp_pending_del(data, msg);
> >> =20
> >> -			data->timeout_cnt++;
> >> -			return -ETIMEDOUT;
> >> -		}
> >> +		data->timeout_cnt++;
> >> +		return -ETIMEDOUT;
> >> +	}
> >> =20
> >>  	return 0;
> >>   =20
> >The mix of using a goto error handling block and not in here is not eleg=
ant but
> >it's would take quite a bit of reorganizing to tidy that up.  One option=
 would be to
> >factor out this bit
> >	mutex_lock(&data->comm_lock);
> >
> >	status =3D ssp_check_lines(data, false);
> >	if (status < 0)
> >		goto _error_locked;
> >
> >	status =3D spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
> >	if (status < 0) {
> >		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
> >		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
> >		goto _error_locked;
> >	}
> >
> >	if (!use_no_irq) {
> >		mutex_lock(&data->pending_lock);
> >		list_add_tail(&msg->list, &data->pending_list);
> >		mutex_unlock(&data->pending_lock);
> >	}
> >
> >	status =3D ssp_check_lines(data, true);
> >	if (status < 0) {
> >		if (!use_no_irq) {
> >			mutex_lock(&data->pending_lock);
> >			list_del(&msg->list);
> >			mutex_unlock(&data->pending_lock);
> >		}
> >		goto _error_locked;
> >	}
> >
> >	mutex_unlock(&data->comm_lock);
> >
> >into a helper, use guard() for the outer mutex and then direct returns.
> > =20
> Hi Jonathan,
>=20
> Thank you for review and point,
>=20
> If we convert this change to sub-function then suggested use_irq would be=
 shifted to sub-function; then how would you suggest to handle that bool ?
> - keep msg->length as it is
> - in sub function __ssp_do_transfer(data, msg), should we pass additional=
 parameter to bool for further execution?
Pass in any additional parameters you need. If it becomes too long then=20
this was a bad idea and you should ignore me ;)

J
>=20
> Or any better alternative to handle both ?
>=20
> Thanks,
> Sanjay Chitroda
>=20
> >Then we only have a simple check on return value from that to decide
> >to increment the counter and exit on error.
> > =20

