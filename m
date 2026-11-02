Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605677;
	b=YRQdTMyeD8yVCwq/HIq81eCJhj64ATDGNUCkGrLcNDxu6a6RL0tmRoLxRaP8I8F+awbq
	 LwwfnVVeVQ0zhCKuGAbj2p7Q+NXOCHWyaHsz3rghTlMwosWjiFct4z41ixS9zNX+utYfW
	 D7uHbFpHH+lTMJvE2Vxv/9tNKhdaafSvQUEoISBfhriGL4X1wGw3+PLIcHp/3e3rT5k1p
	 sEWtXFvpP6fPPOp1E1PwF6XHoZVOFjG28lMpPakkwz/IPRc1xfu5dht8LTeo9unIsRvB8
	 7/7iK1Mcm5W/j+W5uaYQKnHef3OMbWx0VSDbE/Nd88Xb6FiVdjzKL/Jxko2bkKpCunQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605677;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MIME-Autoconverted:Content-Type;
	bh=BNo4/iuAZIBnS8LbrtNDLQV/Nkc0eC8EFaUPz20grvQ=;
	b=IQDOk9igXuI34ZVfbr1IPjJVhIye+bFa9nh84tfmya/W3y3wluL3PggTk8Tg9yc8tisI
	 A7VydlRBvNtuhothuUgOV5tC6CwvFWPxl7/NGXJdqUc4x38rl1d3hFzp24fryz2weg4Sk
	 3lRrx/y9qpjTWfMHehi9Rkbo0FCsC8YogJ5Mg8PnguEl9FHqnmecVH5tfHQMgCM6dT2Dg
	 FRPfgRVRDUS6/RVVjcTulTduM4zhspzlSWJM2A8esb2hh9zsAbf+17/a5Wd3WV3U5EcuX
	 3xkWENJbBqj8wpHh/H041W/diKpEstitL2lyXCPGvTEMYnnaqE6GBsld8AtoUg2TfHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=temperror header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=i73bNfIR;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=uFxbUnTq;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2195606A326
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2195606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=i73bNfIR;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=uFxbUnTq
DKIM-Signature: a=rsa-sha256; b=i73bNfIRbmXSLp3KM5u8Q0st9JXdckwgy3KAwaQWsiwhjt4ft4dBQmRJJ2LXIr5t2vSIr7+4hOGibMvCy2UJ/TDiWIMLmILqOzAHJsezhNO1s4xrghSsykVUBfGpb3pmFxR6ttJ9k+MKGk93iUcocGtw9eZ9Wr+wcjm9Vo40SOii5/r10/cwqYqjUxekzBtuo3UvfKYwPGfnkO/0ghKcziBcM4okD8yEqlahGM4Qcytq7zB8APLaeZLGYhgQbZAitD32nBUaJizZATw4rl18pbiyHpZ+ArDaFhp5acMaxFyuyfamyEJlyY6U6SEFmbruJjdQW+zXpEej8CrUUZEpDQ==; s=purelymail2; d=arkamondal.net; v=1; bh=ngn+fmdUroBHY0zq0tNed+r8WrmIeI/bXa0/kw659us=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=uFxbUnTqz/c0S9kZWlT39oUtkXUpEZetYqpNJgyuj7+wuQUKQYU23MspKz74rd3eWD/LUGXWDnXooNQ8sU+WXLfg+DDeMTjfGIcmEGcZRwI86MqG7P2f2buMALPsgF5V9wZYflZ8be8f4+MWSa6u9OSGOCY58rVI5GrsZa3ghtAz09OQe1XTdEEw+47xYdNPyIdfprMjR6WhsCMvrxE9BwWyLhUK1pDwgMCTeuoULLdQfFCwZ1RTk5Xx6pscRXSqNnoVMTq8UbD7NEQOMVPn6kfeInHgEyAB6bO52T7Pe0F1Lqc7e67i+rNjNrVyAop2GXVWknYCr1Ayhx2sy03+gQ==; s=purelymail2; d=purelymail.com; v=1; bh=ngn+fmdUroBHY0zq0tNed+r8WrmIeI/bXa0/kw659us=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -754453042;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 02 Nov 2026 07:47:21 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Robert Eshleman <bobbyeshleman@gmail.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH 1/6] iio: light: isl29125: Report the scale list via read_avail()
Date: Mon,  2 Nov 2026 16:46:55 +0900
Message-ID: <20261102074700.63075-2-arka@arkamondal.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102074700.63075-1-arka@arkamondal.net>
References: <20261102074700.63075-1-arka@arkamondal.net>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The intensity channels set IIO_CHAN_INFO_SCALE in
info_mask_shared_by_type, so userspace reads the scale from
in_intensity_scale. The values that attribute accepts are listed by a
custom attribute named scale_available. That name carries no channel
prefix, so it is registered at the device level and is never paired
with the channel. The core would have called it
in_intensity_scale_available, which is also the name
Documentation/ABI/testing/sysfs-bus-iio gives, so userspace does not
find the list where the ABI says it is.

Report the two values through read_avail() and drop the custom
attribute group. The values and the text they print do not change.

Fixes: 208335138001 ("iio: light: isl29125: Add scale_available information=
")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/light/isl29125.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index 9e0b7e6a3ecf..0efe0d72f9d6 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -58,6 +58,7 @@ struct isl29125_data {
 =09.modified =3D 1, \
 =09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
 =09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
+=09.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE), \
 =09.channel2 =3D IIO_MOD_LIGHT_##_color, \
 =09.scan_index =3D _si, \
 =09.scan_type =3D { \
@@ -198,21 +199,31 @@ static irqreturn_t isl29125_trigger_handler(int irq, =
void *p)
 =09return IRQ_HANDLED;
 }
=20
-static IIO_CONST_ATTR(scale_available, "0.005722 0.152590");
-
-static struct attribute *isl29125_attributes[] =3D {
-=09&iio_const_attr_scale_available.dev_attr.attr,
-=09NULL
+static const int isl29125_scale_avail[] =3D {
+=090, ISL29125_SENSING_RANGE_0,
+=090, ISL29125_SENSING_RANGE_1,
 };
=20
-static const struct attribute_group isl29125_attribute_group =3D {
-=09.attrs =3D isl29125_attributes,
-};
+static int isl29125_read_avail(struct iio_dev *indio_dev,
+=09=09=09       struct iio_chan_spec const *chan,
+=09=09=09       const int **vals, int *type, int *length,
+=09=09=09       long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SCALE:
+=09=09*vals =3D isl29125_scale_avail;
+=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09*length =3D ARRAY_SIZE(isl29125_scale_avail);
+=09=09return IIO_AVAIL_LIST;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
=20
 static const struct iio_info isl29125_info =3D {
 =09.read_raw =3D isl29125_read_raw,
 =09.write_raw =3D isl29125_write_raw,
-=09.attrs =3D &isl29125_attribute_group,
+=09.read_avail =3D isl29125_read_avail,
 };
=20
 static int isl29125_buffer_postenable(struct iio_dev *indio_dev)
--=20
2.56.0

