Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5013C276F;
	Wed, 13 May 2026 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665727; cv=none; b=Tn3hG/uizDcf6Em3cj/v506Ua2v55QJWUkBVHe0SyeX+LllIVJ2/21SYDre31QRCip4ERHf4wRDWRn6GvtsuSv8Npc7BfeK5pLPx/vtp1xuQwn7htovwahGaAPtkrt945VqGWlqLMAJGXFFkHZlYD4pVukCLpaxEFjrlAKWgrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665727; c=relaxed/simple;
	bh=h6zEhnKiZO4AK+ovjspwZRIiCSxS4eHud3WQyKCI6W8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CD+qF88d+JJKBgvtMFjihSwjj85n9aQrXsRfGgulO5Q/aatAuWHVhTzpsinHReArlYHTDZ/4AlRyjwYGMF5MH5YDDYkX6rUmZvFdNE9EYNhdyuESR+TdMwO1yIf6fpWVZUUw7avsnSy0ZYp7o+n9LINACMkc+wEvT9lsq3++Xm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9uDzFDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9uDzFDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78311C2BCB7;
	Wed, 13 May 2026 09:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778665726;
	bh=h6zEhnKiZO4AK+ovjspwZRIiCSxS4eHud3WQyKCI6W8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K9uDzFDnS8v7C3pUMpD25t7ZG39xpqjimsyorx2WnmycPadk6J0LVbgh8lDsgvVMp
	 kjb44z3g63nNp4bCbYL7h2w+e/UJgdl9rwruuY7k9mm6e2Nl7x8v6dpwLco2wlfrrd
	 tAvhYinQM8EqmzwZ6YtWSslkCsc3socvGsNi+VY7kwaG9KwSlyJiH3YK6rL3SohcaR
	 wnYEz7z6BYNMz3IJDPcVORUpGk7mENj1i8lo/z/02DnHFKAqwbWOjctkjCvxDFqnN/
	 q55ECKNCAgjOhfa/YdRbLfq+NtTSYp5JtIE2nmBECQb0iUvMfepHZj5nZyhosWJ9Z3
	 ns4S2rOXmHVXA==
Date: Wed, 13 May 2026 10:48:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: oe-kbuild@lists.linux.dev, Salah Triki <salah.triki@gmail.com>,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org
Subject: Re: [jic23-iio:fixes-togreg 31/32]
 drivers/iio/potentiostat/lmp91000.c:353 lmp91000_probe() warn: missing
 unwind goto?
Message-ID: <20260513104839.72b5a06c@jic23-huawei>
In-Reply-To: <202605130437.SgMZ43gQ-lkp@intel.com>
References: <202605130437.SgMZ43gQ-lkp@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 10:02:40 +0300
Dan Carpenter <error27@gmail.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fix=
es-togreg
> head:   2ec11ebb4d0dea4aa9604f8336cd1e1c390d5dcb
> commit: 82764dcb3643c70649f14fe8e92e667955574a8c [31/32] iio: potentiosta=
t: lmp91000: fix probe order and cleanup paths
> config: i386-randconfig-141-20260512 (https://download.01.org/0day-ci/arc=
hive/20260513/202605130437.SgMZ43gQ-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> smatch: v0.5.0-9065-ge9cc34fd
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202605130437.SgMZ43gQ-lkp@intel.com/
>=20
> smatch warnings:
> drivers/iio/potentiostat/lmp91000.c:353 lmp91000_probe() warn: missing un=
wind goto?
Dropped for now.  Salah can you take another look at this please.

Thanks,

Jonathan

>=20
> vim +353 drivers/iio/potentiostat/lmp91000.c
>=20
> 7d8b3e100abeeff Uwe Kleine-K=C3=B6nig 2022-11-18  295  static int lmp9100=
0_probe(struct i2c_client *client)
> 67e17300dc1d760 Matt Ranostay    2016-09-24  296  {
> 67e17300dc1d760 Matt Ranostay    2016-09-24  297  	struct device *dev =3D=
 &client->dev;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  298  	struct lmp91000_data *=
data;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  299  	struct iio_dev *indio_=
dev;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  300  	int ret;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  301 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  302  	indio_dev =3D devm_iio=
_device_alloc(dev, sizeof(*data));
> 67e17300dc1d760 Matt Ranostay    2016-09-24  303  	if (!indio_dev)
> 67e17300dc1d760 Matt Ranostay    2016-09-24  304  		return -ENOMEM;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  305 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  306  	indio_dev->info =3D &l=
mp91000_info;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  307  	indio_dev->channels =
=3D lmp91000_channels;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  308  	indio_dev->num_channel=
s =3D ARRAY_SIZE(lmp91000_channels);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  309  	indio_dev->name =3D LM=
P91000_DRV_NAME;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  310  	indio_dev->modes =3D I=
NDIO_DIRECT_MODE;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  311  	i2c_set_clientdata(cli=
ent, indio_dev);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  312 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  313  	data =3D iio_priv(indi=
o_dev);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  314  	data->dev =3D dev;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  315  	data->regmap =3D devm_=
regmap_init_i2c(client, &lmp91000_regmap_config);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  316  	if (IS_ERR(data->regma=
p)) {
> 67e17300dc1d760 Matt Ranostay    2016-09-24  317  		dev_err(dev, "regmap =
initialization failed.\n");
> 67e17300dc1d760 Matt Ranostay    2016-09-24  318  		return PTR_ERR(data->=
regmap);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  319  	}
> 67e17300dc1d760 Matt Ranostay    2016-09-24  320 =20
> 4d031666560da23 Gwendal Grignou  2021-03-09  321  	data->trig =3D devm_ii=
o_trigger_alloc(dev, "%s-mux%d",
> 15ea2878bfb2550 Jonathan Cameron 2021-04-26  322  					    indio_dev->nam=
e,
> 15ea2878bfb2550 Jonathan Cameron 2021-04-26  323  					    iio_device_id(=
indio_dev));
> 368e8718875f17a Dixit Parmar     2025-08-22  324  	if (!data->trig)
> 67e17300dc1d760 Matt Ranostay    2016-09-24  325  		return -ENOMEM;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  326 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  327  	init_completion(&data-=
>completion);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  328 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  329  	ret =3D lmp91000_read_=
config(data);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  330  	if (ret)
> 67e17300dc1d760 Matt Ranostay    2016-09-24  331  		return ret;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  332 =20
> 82764dcb3643c70 Salah Triki      2026-05-07  333  	data->cb_buffer =3D ii=
o_channel_get_all_cb(dev, &lmp91000_buffer_cb, indio_dev);
> 82764dcb3643c70 Salah Triki      2026-05-07  334  	if (IS_ERR(data->cb_bu=
ffer)) {
> 82764dcb3643c70 Salah Triki      2026-05-07  335  		if (PTR_ERR(data->cb_=
buffer) =3D=3D -ENODEV)
> 82764dcb3643c70 Salah Triki      2026-05-07  336  			ret =3D -EPROBE_DEFE=
R;
> 82764dcb3643c70 Salah Triki      2026-05-07  337  		else
> 82764dcb3643c70 Salah Triki      2026-05-07  338  			ret =3D PTR_ERR(data=
->cb_buffer);
> 82764dcb3643c70 Salah Triki      2026-05-07  339 =20
> 82764dcb3643c70 Salah Triki      2026-05-07  340  		goto error_unreg_buff=
er;
> 82764dcb3643c70 Salah Triki      2026-05-07  341  	}
> 82764dcb3643c70 Salah Triki      2026-05-07  342 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  343  	ret =3D iio_trigger_se=
t_immutable(iio_channel_cb_get_iio_dev(data->cb_buffer),
> 67e17300dc1d760 Matt Ranostay    2016-09-24  344  					data->trig);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  345  	if (ret) {
> 67e17300dc1d760 Matt Ranostay    2016-09-24  346  		dev_err(dev, "cannot =
set immutable trigger.\n");
> 67e17300dc1d760 Matt Ranostay    2016-09-24  347  		return ret;
>=20
> Need to goto cleanup before returning
>=20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  348  	}
> 67e17300dc1d760 Matt Ranostay    2016-09-24  349 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  350  	ret =3D iio_trigger_re=
gister(data->trig);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  351  	if (ret) {
> 67e17300dc1d760 Matt Ranostay    2016-09-24  352  		dev_err(dev, "cannot =
register iio trigger.\n");
> 67e17300dc1d760 Matt Ranostay    2016-09-24 @353  		return ret;
>=20
> Same.
>=20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  354  	}
> 67e17300dc1d760 Matt Ranostay    2016-09-24  355 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  356  	ret =3D iio_triggered_=
buffer_setup(indio_dev, NULL,
> 67e17300dc1d760 Matt Ranostay    2016-09-24  357  					 &lmp91000_buffer_=
handler,
> 67e17300dc1d760 Matt Ranostay    2016-09-24  358  					 &lmp91000_buffer_=
setup_ops);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  359  	if (ret)
> 67e17300dc1d760 Matt Ranostay    2016-09-24  360  		goto error_unreg_trig=
ger;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  361 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  362  	data->adc_chan =3D iio=
_channel_cb_get_channels(data->cb_buffer);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  363 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  364  	ret =3D iio_device_reg=
ister(indio_dev);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  365  	if (ret)
> 67e17300dc1d760 Matt Ranostay    2016-09-24  366  		goto error_unreg_cb_b=
uffer;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  367 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  368  	return 0;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  369 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  370  error_unreg_cb_buffer:
> 67e17300dc1d760 Matt Ranostay    2016-09-24  371  	iio_channel_release_al=
l_cb(data->cb_buffer);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  372 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  373  error_unreg_trigger:
> 67e17300dc1d760 Matt Ranostay    2016-09-24  374  	iio_trigger_unregister=
(data->trig);
> 67e17300dc1d760 Matt Ranostay    2016-09-24  375 =20
> 82764dcb3643c70 Salah Triki      2026-05-07  376  error_unreg_buffer:
> 82764dcb3643c70 Salah Triki      2026-05-07  377  	iio_triggered_buffer_c=
leanup(indio_dev);
> 82764dcb3643c70 Salah Triki      2026-05-07  378 =20
> 67e17300dc1d760 Matt Ranostay    2016-09-24  379  	return ret;
> 67e17300dc1d760 Matt Ranostay    2016-09-24  380  }
>=20

