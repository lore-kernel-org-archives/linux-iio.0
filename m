Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192237081A
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783902801; cv=none; b=fPHyTpqEpr8szGe/CL5PEZGpzJV4mncMLwmkNYdHDMT81SGM5W6cEnUcg5i9gTAq0NXvJTDovQK6QCJmvE0PxVINwOxl+L3X7mgX/xHfsqarbHHlEZyDJgrSKhnFnd1WzpjNQgabgBF1e8SyGJVURpYIy0i1JZ9K0gYxtaPtKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783902801; c=relaxed/simple;
	bh=T0bmxuDEd3/J3xqv1cuE3jF8wxqe+yrO2LZe9w8bDHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRisgcEhsgM7w4mQksS3GusKkKNhqUiiGdIMJndTsKkI/pBPeyTd6S9jHSZCKihfNPRCNrk17CNC6Hofn5z2+V3NGHIQPE0G7vy8txqHNaL7sxZ7jqn4DuMu1s+iFJu23E+FaXfrnhICCWEKU2ISUwcv1SOQMPCnsQ3XRYUIU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dj1IS0N9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XyKb6rAj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dj1IS0N9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XyKb6rAj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CNUgSe3809941
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T0bmxuDEd3/J3xqv1cuE3jF8wxqe+yrO2LZe9w8bDHc=; b=dj1IS0N9fiDEisEN
	2opjupITBFEunYno/r9d/iMg3afIGD8xWRGxrw2B/xv+tECiOqit/zfXiWyUK8+Q
	uku98X7Sf1zsBcN9v27BQ+x9WD27fvzRzn5ELuJYP/f6r2u0KHXIwZf19Hd6/q1i
	rikYzHTq59UUQFfrIRqWGzyDIsFzRfCsT83v1uzZ+WILWLuZMbWRT/e7IA7cD6ne
	TqD5gcN91jsOYPT3bAVmp99VYvOYCTx+btV3JXMV8F7k4ST3TfabUlIC8w4GRchR
	dOtKeMj5PGeKer77a7I0ilSIGQUsI1wQHqeWuToF498yF5vm1csXlxalYic0ncIL
	flTB8Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbekckr9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:33:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso1606955a91.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 17:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783902799; x=1784507599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T0bmxuDEd3/J3xqv1cuE3jF8wxqe+yrO2LZe9w8bDHc=;
        b=XyKb6rAjYqEsGH6ENJghAOc6b4AyYpbtrBgjREnAB5O0elTgwFaVaD+LuYvRHooADZ
         XdFe2e182O0+dOC4cn6TCOvaR2LVJmU5ozDo54WQ72DpTqcTC8hBapOChx0LMJFmwmMW
         X1d3ZxhwbqDVjqS8UxV7+nqZc0xvlaAF9hf1Wzyqa5Suzyt3HrZw5O6oLyG2cq/DbI8/
         qEbCQyecASybm/tgHRAQ2hfQ6VPmNUTKeUVM5OA3yXIurDmkEBT49gXzG95zdvKYz26Y
         ZKZ48befAe+NHCcJRHUip+wWhJY6zyJqOhLbHnS8sxibHDEpshCI+cUMJ1YkhqMC9SMu
         lOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783902799; x=1784507599;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0bmxuDEd3/J3xqv1cuE3jF8wxqe+yrO2LZe9w8bDHc=;
        b=sHflRT3Zi+Cy9hBAuCpESaAtujvosmxXXUvCFVDN5pMIbatBEzVtl14Gz9yrwG+r7k
         Av+VUu/rTyrmk6r3kDTP+i7WM1rNoC9wdA3ZBoqOKI9Z/EIkt3K3h6y6Rfj1GTy+1oQK
         sde+gMVxQ0vw4eMcFzz8BGJx4d8PaQCmqdcpsQPsrcAjUaFkAVkLo7SnsinIehzLQA8i
         uRkrl6ixMsxC3liuczJkM4+6V1AjJNYxWe7YW/fhdcnm7l7ZnMf4MFhBI403kyla7gUO
         eq1jrlPTHI0eG6uh5Hz0Jymjni9KJmkPawjCsnCg1VBpjIFrGC8NT0HU5Lae8ReJe2TA
         ucDw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8YWn4j8vGZE3/Wq/on8jjp7pMUIHUqi/z+xrAnawFJmNuihv7UDSl2D9DubhyTn5tQlnYJnnk0KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzjoTwHxsAIuDxpSFNrYrDp+0RDeYRgRGID3HIDXJqOYEPs8QG
	LFl19Ahzkq+HC+6bCamXzXuv2nabuZ71B0a6gCkTIugeba2nQIxLttD58rXiiWS5N3hR5UZzzPE
	x2XcdMBKcUrOvRnH4rYFLleZMj/GFkbg5CSeD9mgzODVZ/qFFWYMQUUPU9JHgbl0=
X-Gm-Gg: AfdE7cnh3NXYQ6vme30B2qzWDp5TpHqt3qTalI6BPlWVpmdU8YSBmEVYNrRTYfTyqz7
	OArL9nw6yxuEzDqaTweKJx+H7m2H29gV0xBupMuKhS9y7hschmpb4JVbnw3TMpZ0fG0TkOgHY/9
	LuRBVgc+j9RhOwyX8YVV0d9DzIaMdpUEMy2SKlxN43n9iKjAebBzXproPcm4gJrxYlxe4LZdN43
	61MRWE9aed4qX7v4hbpJzZS+1HnWVHq/XAQKgVGD25mJFteWQ6ggMdin5klNF5qdU+1+huoWlxI
	awbjdw14pHLZ1x2TDqVpmwGB42fAfLsw5I3HHZJ1sf67FDJAOvm9LRaAA4wAuBXv5V80TBIkhby
	T9yNAFoXdMQWVgO+TpKOE2RVn8BI=
X-Received: by 2002:a17:90b:562e:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-38dc761ab25mr7330242a91.6.1783902798680;
        Sun, 12 Jul 2026 17:33:18 -0700 (PDT)
X-Received: by 2002:a17:90b:562e:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-38dc761ab25mr7330218a91.6.1783902798263;
        Sun, 12 Jul 2026 17:33:18 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a583a22f8sm5493983a91.15.2026.07.12.17.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 17:33:17 -0700 (PDT)
Date: Mon, 13 Jul 2026 01:33:11 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: rva333@protonmail.com, David Lechner <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iio: adc: mt6323: remove unused header
Message-ID: <20260713013311.1dbea6ef@jic23-huawei>
In-Reply-To: <alQRYcO5grXoEk39@monoceros>
References: <20260712-mt6323-adc-rm-header-v1-1-d96395d1a323@protonmail.com>
	<alQRYcO5grXoEk39@monoceros>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAwNCBTYWx0ZWRfX5iyt2XNzCU+O
 GGO8dEzO6C5u81+EyGbVENnvCmsQIZO/vTTq/3VbtZtlZZKFG4wMfH60l3jhdP4dNsPOqbH9RzY
 eTN+VsFPbPp6IEP0qdpRmwykuSqXg99knP5usRXVNRvmDDBLCOxD6V+gso30VWjWXMgBdRcg1mZ
 cbBAtrT88lz76Iej5ahtX9ds2AxWv0u1tpolsDjtFwxADsHvOxdL8o3K/7nDthkK+DsN2OhTBrk
 VjcyyMH/Oz0GCtmJGYSWW4arzYGSAtLPgZJI18XcLTEXnuAN9QmSAwxfEyTGNkTxXQVlrG/iCTt
 ANHgplpYt7SI762lYC6RhOg69kgXviDRCb5l2PDQnKFZMzSI+8p8yhJlWnxvK2xUFCxDAb8F+Qq
 7v04tb2O5QoRC55Ky87tsD1TS2Q/rqtu9Vd79nEWT87kBrr8bQW7Eod4Y3CjmJtydazCCytTC6x
 Nxs8FQkBVHEp17tb9Xw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAwNCBTYWx0ZWRfX6bTum1amGk1h
 8ErTQ3oOzHTzU0or5CnQ+QnwUfN9RHBlEOax8MFhmAk14X5Vy+ViEXyYC/kMw8+GzQvvNKomShC
 Qt4EE3QqE12VCz1C5MOMZqZbvVxmYu4=
X-Proofpoint-GUID: K8_58PGI7fEgU9b8VFHpgsqqgeRzv9ML
X-Authority-Analysis: v=2.4 cv=XNsAjwhE c=1 sm=1 tr=0 ts=6a54324f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=IpJZQVW2AAAA:8 a=sfOm8-O8AAAA:8 a=4veh8QkxCU5BpHafbtMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=IawgGOuG5U0WyFbmm1f5:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-ORIG-GUID: K8_58PGI7fEgU9b8VFHpgsqqgeRzv9ML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130004

On Mon, 13 Jul 2026 00:14:45 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> On Sun, Jul 12, 2026 at 09:26:36AM +0300, Roman Vivchar via B4 Relay wrot=
e:
> > From: Roman Vivchar <rva333@protonmail.com>
> >=20
> > Remove unused mod_devicetable.h header.
> >=20
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > ---
> > A small cleanup for mt6323 auxadc driver.
> >=20
> > This patch is based on top of iio/togreg branch. =20
>=20
> The only device-id struct used in this driver is of_device_id and this
> is ensured to be available by (e.g.) <linux/platform_device.h>. So:
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylib=
re.com>
>=20
> Thanks for supporting the effort to get rid of that header,
> Uwe
Applied to the testing branch of iio.git

Thanks,

Jonathan


