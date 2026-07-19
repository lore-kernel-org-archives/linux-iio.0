Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C8A21ABB1
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 02:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784426466; cv=none; b=mCGw4Ot1s7xv5oyonsVlGCURftKxPixhBQSfW3rf5a8rR5YNipqUDtVKgKKTMd/TPu+0pX254IG0+TsgZl7NBdF2o/dcKAW+5mUB3sCbG/4memmg8OKCNL9U7J+qOhcdsGUJEwnEXWiDB9M/jy4tCAhS1rBijSaWs+dbYYbx9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784426466; c=relaxed/simple;
	bh=9/uNyYhJ/383uK+5X5Nx6mp9pICY/zart5bRU4jAJ2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLflRYcwR3W+iu4d1A2N29b/vbiahNSv7jzTgFi3najuLEEGYphbXe+YqScLQmntNkUTVThz/LQy99Eo3yekn9NbFgwmSx6+74JSKswa6Uxz93BK1fm2oZ3q5dDnl/OGZEAStsJYih6yw0gcT6wq6w9JZ2X6XhKJWNySVijFJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ui9zRa32; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jEYxOKRp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ui9zRa32";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jEYxOKRp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN1wNq1735635
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 02:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZMxleJTNpev9DmeiF2lGmBzAfQi2OHXiuw3G0xua8IA=; b=Ui9zRa32EegPEaiU
	65hDvM9PkTimZq72o/LqDJ9B0XvLJV+SOeJZQ0zrsWUCWUAcouB2ZZGzeg2IeUdf
	ZeNKfw4wPHPvKpcsTOeLRcc7kKWk7CAM1OX/p4gJCRkVBhcveAOcUExh4WrHiGmz
	IdcIrYtwMVtREf3OaDSJnUBFAfq8cKXQnp17jM1rnBKyoghdOSoWg8KQ5Mrwr1Fu
	fo9SY6CdaYq/+f9qXDr7jkNzF1jwXQmRJXsicHA99ksptThGZMbS51/qg4Evh7d8
	QFfHSfsqL9rvk5P16Ay0FPrSkSZlZLvWQSrp1Cgk3/gRPhMYWZmylb3M1P8jY/Bl
	45nQ3A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7sv54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 02:01:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so134626485ad.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 19:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784426464; x=1785031264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZMxleJTNpev9DmeiF2lGmBzAfQi2OHXiuw3G0xua8IA=;
        b=jEYxOKRpvx/rzi44Kbc+ENXlqE6Ccyn4SL9MDCKArpWcSU3B0OBeh3dNJPnBPnRPkP
         nmVt/Mil9ewYPhmvPmu/0Ks4H3i9vKCw3fTgBKpQPbxGTewSj/UQ617nWpezw6Wk2d6k
         QZfZw4OuzXiBI7muPLmHwNJZsHsbC0GAatAc77H/DIUgHdqGcztcaW8WDyQlRnqC3Ac1
         lhsj0j+Ru0td6uf7A2AQdFrT3lbQ2qeNpGM3sPF8NgoV52EiTVx4pVNnqXrEgXRFPrnM
         xqxm3goxl07SABPSsaB79JIEOBiachbu5NgxA3E6l/x68/dlCBQ/SBot6QYmiTbjZomU
         qd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784426464; x=1785031264;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMxleJTNpev9DmeiF2lGmBzAfQi2OHXiuw3G0xua8IA=;
        b=ocfgSROUvWU10k3AoR4YTilpBnx0mOeUg+Puoy8WGdVqSOSge/U7QJZ6ZTNcwQw+x4
         7P86ldzzJv02jIRHMtsQiwVGpbsBXawSmlEdY7u7rsv8Qy2KF6zZQlj6VKvEOqbQichY
         Lxp/h73OUTBSh1sghxy8k3eFgIKHqYdcKVdff/DdWJQddjTvymZf554hSPE9t2jPGpS9
         yRco+ks2jDyxMmVolwBICLKc/WeId1xV83R8CWlddQyHS9XXQgCwspT2OzE31yM5zrW6
         NjeOrJeAcqVFgKCIJUBn4+h8VVwXraLTd84gN202dZA0w2YU8uCvsu/lvBEzZ7/UX0+K
         cyaA==
X-Forwarded-Encrypted: i=1; AHgh+RryP8+SYpbn7OHCIxPN5dVYWxWdYWdIWY2LOt1e2IDYF1RUPakshtROLdeY4ajATdA6Iga0J5/SrtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIlQOwJ9AFEhBc1pBzA4QU7spl1Mo+LyGreGgXj4USlIGW5XD
	AvDyAKgw6gf2JIr3Gt7nR4PJ+77fnxieydOo/ANZDQ7P7+INRLZioPkGdfBGDglaTugs52sOgx8
	Za2UTtdfPQjBeKu4/xOSC2cBOQn0COfoMLeiopa9MQMotqFFTDn2y5tn70ALvnOQ=
X-Gm-Gg: AfdE7ckNeaarjFRE6IwVNVvfAxG6rN4n4cN2vd5mRMX8pJuuw0Ls0EAY/TUJu+UQUNd
	/604tUWLWvqBPkO7H/A3LcVPxNmM/hW0rSjJO/973YFW2MHhzcHkVuA7a9X0JutyP/pr59jpEoy
	xfF9vuAiGo/JQI9TxHRa0VNrM+1bRm9kIygGUzbQajfA1WE/XVlJtGN1ushMQ4SQCJeddBPEZ5H
	e2wSkrsvcSBqSPODihndtkcXMhpzITKBMAd5d9DwC9hr/iN1t7fvIjUpPCyJiASOkCvnNIpovKL
	eb0NWgZBIpQEEGBR0HyiHmRC0A0kJwxWQNhUKWs9KrJvbrZAGA3mVRec+RMb72ZnCSMT+aO+vsG
	d1tnvW1pthCxF0AWL
X-Received: by 2002:a17:902:da81:b0:2c6:8d95:fd6d with SMTP id d9443c01a7336-2cf34892342mr92987405ad.21.1784426463587;
        Sat, 18 Jul 2026 19:01:03 -0700 (PDT)
X-Received: by 2002:a17:902:da81:b0:2c6:8d95:fd6d with SMTP id d9443c01a7336-2cf34892342mr92987015ad.21.1784426463052;
        Sat, 18 Jul 2026 19:01:03 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db2d9sm34323565ad.43.2026.07.18.19.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 19:01:02 -0700 (PDT)
Date: Sun, 19 Jul 2026 03:00:57 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <20260719030057.1c1be07c@jic23-huawei>
In-Reply-To: <alewxmtqJmEkRfVm@ashevche-desk.local>
References: <20260715-iio-dma-cyclic-v2-1-268a3a28ff84@analog.com>
	<aleX0UD96t12s44k@ashevche-desk.local>
	<56f7bzba56atwu4qvgxpm4p7k347m4oqqdy3336rsy7xi3e7oq@jzoj2jtu3qu7>
	<alewxmtqJmEkRfVm@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfXzW9fz0IT/KsJ
 /xSJY705lDkHUDPsPI1dJXJlMk6oDJk2JKYX/GOVaJ2APcVcykLblcllEonfhATa3mgadThnij2
 krnoceo1socGsBIoFORfz589CHDDEWbFVgsLJtVzNNeghZw0lomy28WBZ1m9ovufMe02DxecVC0
 v1xc/9jQ/Z8zHy0UbK9Rt//0SXoIrNEHGbQegj6uwr08Z+K1eQuBIbUd85ghPE3Bqag4Vw8ZzoD
 yTaLnQaMs6yDVE8uxteARnvvKBP6UcCMD/ckS5EJzO7U4VN6F1QGYvr5IJodkl6TIHrLo4hXN7J
 OwGlEG2HaiY2yCUnWct0FnKG9EiCqBCp8BKJgRwqlWm8sbZ42wzpPYASjK7ie0A8p7dNCrG07sn
 hG6m/mp6BFoU4UGNbT1NQJa7b7TAJczoEPT8Tt4OyQizcCWimvWW1sHzqiaYQL5zGgC0WAlnonZ
 da5tHm9ekfTjtC7wZ2A==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5c2fe0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QyXUC8HyAAAA:8 a=uR47NWKwH8U3VX_NRrwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: -oltqRdHzmFtfY3rrDUtTUVeBxLmH8Ni
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfX2bQN2aNLquiy
 tI7MYnX+U9QG0CKl50vGue4eXjRTYRfvtTyLroOWszNu7K4gUBFhw9wDJ+sPGIS5AH704zXy52r
 yaqZmzuo4MRppOLw3Zz11nNqQNQ3pBE=
X-Proofpoint-GUID: -oltqRdHzmFtfY3rrDUtTUVeBxLmH8Ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190017

On Wed, 15 Jul 2026 19:09:42 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 15, 2026 at 05:13:32PM +0200, Nuno S=C3=A1 wrote:
> > On Wed, Jul 15, 2026 at 05:23:13PM +0300, Andy Shevchenko wrote: =20
> > > On Wed, Jul 15, 2026 at 01:24:53PM +0200, Nuno S=C3=A1 via B4 Relay w=
rote: =20
>=20
> ...
>=20
> > > >  static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer=
_queue *queue,
> > > >  					     struct iio_dma_buffer_block *block) =20
> > >  =20
> > > > +		if (block->cyclic)
> > > > +			flags =3D DMA_PREP_REPEAT;
> > > > +		else
> > > > +			flags =3D DMA_PREP_INTERRUPT;
> > > > +
> > > > +		/*
> > > > +		 * A new transfer may need to end an already active cyclic trans=
fer
> > > > +		 * before it can run, so always set the EOT flag.
> > > > +		 */
> > > >  		desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->cha=
n,
> > > >  							 vecs, nents, dma_dir,
> > > > -							 DMA_PREP_INTERRUPT);
> > > > +							 flags | DMA_PREP_LOAD_EOT); =20
> > >=20
> > > Logically I would expect this to be a separate line with the above co=
mment. =20
> >=20
> > Hmm I can agree to some extent. I guess it makes sense, yes. OTOH, it=
=C2=B4s close
> > enough to be clear what's happening. =20
>=20
> Close, but not enough in my opinion. This currently is spread over pure f=
lags
> manipulation and API calls.
>=20
> > Anyways, can spin v3 if you feel
> > strong about it (will anyways wait for Jonathan to take a look to make
> > sure this the only pending concern). =20
>=20
> Not so strong, but lean towards my version. Let's wait for his review and
> decide if it will be tweaked whilst applying or next version.
>=20
Applied with this tweak.  Hopefully I didn't mess it up!

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/i=
io/buffer/industrialio-buffer-dmaengine.c
index 639bac135539..ecc02a427b92 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -132,9 +132,10 @@ static int iio_dmaengine_buffer_submit_block(struct ii=
o_dma_buffer_queue *queue,
                 * A new transfer may need to end an already active cyclic =
transfer
                 * before it can run, so always set the EOT flag.
                 */
+               flags |=3D DMA_PREP_LOAD_EOT;
                desc =3D dmaengine_prep_peripheral_dma_vec(dmaengine_buffer=
->chan,
                                                         vecs, nents, dma_d=
ir,
-                                                        flags | DMA_PREP_L=
OAD_EOT);
+                                                        flags);
                kfree(vecs);
        } else {
                max_size =3D min(block->size, dmaengine_buffer->max_size);

> > > 		/*
> > > 		 * ...comment...
> > > 		 */
> > > 		flags |=3D DMA_PREP_LOAD_EOT;
> > > 		...
> > > 							flags);
> > >  =20
> > > >  		kfree(vecs); =20
>=20

