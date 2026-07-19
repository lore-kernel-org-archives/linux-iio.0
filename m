Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC331715F
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784500883; cv=none; b=T3lOvtXSeMeoXa/mV/DWlz1EQn44KLlK7Iu7TQXZXPPvjm7kEOf+jtRfXxVLujnniEUuQfNx2kdxtlUPnHsfHBLFYypBp68KdHNiHZONBoo1v94VPHT9YtlGKqZ9xjAwX4266+udRTerS+ITmSOVfyC4fVeJhyQ6tMFisFVEUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784500883; c=relaxed/simple;
	bh=Hu3XhQuZ0TYfdwZPUp9ITftdo6OiblAWkpOPMAPxcYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2ypJ4+wMljq+qJg1V2qvVXyP0RjtnGht+3dVR3dhguvW4z5ukVqik0hm9Xju5H/lohv2wylI5rOPeFFNNUwmnNruWBlvN5QjG9R9YIDUMg/QGNm8hGSfDhs3IB7YKmK9DW/t4CsfAuICyLtVgfrUzKpPiyfVNpsiZge+0IHe9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MjuAtnZh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=haw8G8R3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjuAtnZh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="haw8G8R3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKQwTU333470
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G14pMQuK0WnX0nA66QGQu45FpDKSIwIW+JyHDqzn2pw=; b=MjuAtnZhnwDXNHXH
	LgBQX1cf2yzabCiy/D1e7BbDxjyeyG9H97/X79zoQDWmWfnLpAuo+gKn0rLXVCLw
	nxULbBkN0wn3w/Qw0kRdbMJwBsgW0hyltX53LlAW/UFy0sfevW3FR/n5VYdzNJL7
	JRossYgWG7kDlJcCeAyupHnyOdtsTGqrzY3QuRW8UfICX1xeWeeY8Zp8BsVEbDiD
	DBAiy1/hRtuBdFPKaIQodhqMAny5ZWWOkhhlkO/HkHkXSdqgLQWsn+8iIN3BrArV
	h4Qsm+zwMY4VhWkRY8iVYLNYVuWExc+R/4C+yNzpSpwHMe9Nl9dVqjSvwmRysrB3
	Bn227A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnkkn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:41:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cefa1a2be6so71385665ad.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784500880; x=1785105680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G14pMQuK0WnX0nA66QGQu45FpDKSIwIW+JyHDqzn2pw=;
        b=haw8G8R3QE72sxBQMwpGvbXH0DdUbX0aAZvQlov7aUEKYQnHO1hI01O1kBYJP/VAoR
         dQBERstvCdDi8+EKZJJhvW2wGqL+/plCPSfZ/G0Du017yX0yyzqe9hJDDVXr9uJ533Qr
         85ygxWdxWjtdTKmymu58McF4Wf6YEuAoeByg8N55ltP7IQH/ZYrSGN9woDJfFaAixhLo
         4TRHIlWg60hIPB/EgbeFb9cJTFRGXjUEs0APY1V1dif+lR6AsbTp/hAqrS16rcuR3se/
         dsSvnatBcXPndrMism0driMGpUJ9Ewo3V1TYhKLCcRBnkUKr7c7PiYuLP4c4qHiQ2cih
         Fu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784500880; x=1785105680;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G14pMQuK0WnX0nA66QGQu45FpDKSIwIW+JyHDqzn2pw=;
        b=RtTRGcMdx6xhgqEQ7AkwAb8FKvAW5X+MrQ4z0cjnO4JTrjNR2sVL3o26J1sb5ATr69
         FAj/UJDWn0X+88uofb796YKyvbHOBD6AuqJHG8zABkVYLFrWrvNjbkLVqdbUUmnQA/CY
         8wa8gY4aBS24ZNYypSaTjcqyHMt0urhem8g9RmLa+RbAYTmBVd5pTBOVJlIjgdrArtKh
         7jqYcWD9ULDcc4hiXXocXeZ2Z7DD+gex6yaXTFPgaEFyIxwW5ufLBDdLkS2pWOq167Ax
         uiQBWBmGZK4fMX8Yu8jYtpP2uKCDg+wUVPLqfbytGkNkgJ9u3wA22P/lmhnKGaaKqngN
         uSTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpv5lOIQj1vBBMNuLGAKnhv3csnHb45k20qGlShNs1WdHTI939MsxLLbka3vqIPZV1i7pT7a/7D/eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGW9tyn8V2Y7FTQe01NtVtYYcA0u8Hp2zyX5ISbEiEyv2dmPkl
	gZ9T2Msrpe2mLx4iaCoC5SpD2yry/esQQOwuRcVLWCZoIZFTzTkCSPIG/PPo12YN4uJK6QbJ1Vp
	tjXFpSIPBI8J7hwdrBjBpPzqRnhb/nATHvrXjEyamZxGSZ0DENvuIhYxG/GADzBw=
X-Gm-Gg: AfdE7cl4QJjTK5JCUgfPxuTVzaRT1cF9mFzQZ/dmzU6HfSwx6s0pEqmvDsyuAciaGrS
	i3V2vLNsEZWBinR2ulvj9XJiz59Xy8/PU9naNvstNVabWg0KWmyczY83dLAwMToilPc7sOXrrTv
	5psuRkPbBl3u6Zcq6ANA11fGPn2g6iuXwtM2EUu5qxbiia7Ag4OPVH7CW8LF+8Z24RJsJ3ndjF8
	ecOitJ4xi38Q71OqSXAZPrPQV1aKqYS5A6sHZkGmkOEqGOYAZbxMl+fj44zC4kVsjPm1aHOtY2M
	g9wBmPdiW6gkd89qfT7ANZYgOjb0OurILO2wQKB/wj+n9Eqgj6A54INlhML68kJ1Ertm3ulCZTV
	FPEDxNYJi5V7jyDSJ
X-Received: by 2002:a05:6a21:b94:b0:3c3:8d4c:667a with SMTP id adf61e73a8af0-3c3ad7a4394mr12721147637.18.1784500879604;
        Sun, 19 Jul 2026 15:41:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:b94:b0:3c3:8d4c:667a with SMTP id adf61e73a8af0-3c3ad7a4394mr12721135637.18.1784500879183;
        Sun, 19 Jul 2026 15:41:19 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb51a2c2a13sm3599068a12.31.2026.07.19.15.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 15:41:18 -0700 (PDT)
Date: Sun, 19 Jul 2026 23:41:13 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, nuno.sa@analog.com,
        andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v4] dt-bindings: iio: proximity: move LIDAR-Lite out of
 trivial-devices
Message-ID: <20260719234047.629d1a8e@jic23-huawei>
In-Reply-To: <7b8973fd-385d-4532-8213-bb0a811081ae@baylibre.com>
References: <20260714215433.41259-1-rodrigo.gobbi.7@gmail.com>
	<7b8973fd-385d-4532-8213-bb0a811081ae@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6pR4AwGST_f69RROjYiYljotIsht7HDg
X-Proofpoint-ORIG-GUID: 6pR4AwGST_f69RROjYiYljotIsht7HDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI1MyBTYWx0ZWRfX+koWF1p1lYsR
 8glpnzrPV5YUDm//EcEoPU5iAQL+jf9ZrVu6Xog0LWTt00Psy3ADHaINQmLwoNhkX0dhY7Zj2HU
 62cQqyf+rKPn0BdAdhUsg0PcAdgfUFamw7eny/zqEbqiwKAroAWjw/UVSmVUZDA32QMXT1GAB6L
 FALSVAZxwdjslTiZ95pfsoCaPN4ekYZ3JL1hsmC6mmTUXY9lL7LzYTrcx6Lh27dLxK1/oxoUW2a
 X2WyzaX+YUemaocyGJeST7adu0CZpGaq7l5Lj/TZ54i+/V34dFyNbvtxTbFnZ8immNaA+/7aQ7k
 W8IQgad9Cf7KKaa6kiGxdZa4k2ebtc4PD3/sJwLqQseaVQ4PW1JylkPaQe2MgQlNGYKgVDIDnCi
 2LZoCOfkn3O7NoVNX3I599S7ARrj17hn9oIQWmnxlV1n5OP6US/smvsPvD/SC4SCwkq0inob1FH
 HZE7XzPK4UJ9nthRHOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI1MyBTYWx0ZWRfX7U7nBrRuMWP0
 ZkE+cMWNsYWUY2CEFK5ZmnzK3d9PK41PK2LyCz323+KxCFnkbYqGnpzBnP28e5YROHINobhjD+o
 UbOCTTxfxpPJHsdGIGzpB+KumJMnNso=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5d5290 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=XdlB6Cn_7BDTE3YMWMYA:9 a=CjuIK1q_8ugA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190253

> > 
> > [1] https://lore.kernel.org/all/c39a2980-f5e5-44aa-9fd3-20e0658f62dc@gmail.com/
> > 
> > Changelog:
> > v4: unify patches rather than using a series to keep the tree bisectable;
> >     rewrite the commit msg, naming the devices explicitly;  
> 
> We lost the IIO driver patch though. The change adding a new compatible
> won't be accepted without it.

I think it is fully backwards compatible?  If so we don't need to do
anything in the driver. We could tweak the name, but perhaps not worth
the bother in this case.

