Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F11448E0
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783903489; cv=none; b=U31Xw4+9E6AB7IUWdvqOF1txImxuRcz0HuxZJ8BDadEi0SfbmbFfOIambXDjzLG0QyyochpPYrvq9AM8gQLF/1YKWAJ/eoNdjiFkE4q+82hr4qOkUqM02vXfYJ1hol0MC5IvAvT6RpsKvtUF51FyVxxF4hmT6NNFs+cI5hrsDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783903489; c=relaxed/simple;
	bh=cVrP9LbImd/DLV4exAMspuFQjCFkyTv6E9ZIoIh5ps4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nN1UdoxOB7eqHlzJBHyKgCzxYLR2CN75rYst5jY9l3ELagkVO9Wc4j4pwLwZPFAZlOWbbcNioPZS/9g4xJWV9UUNZdhxYanD7LP0f2wetoL6D5mBkLmrVwSyr5XehMWknVac6PBr6klRv1En3cDgxOsiNr5nkKHXVv0fGxfXhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BoU7XLjC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=evCHDaXM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BoU7XLjC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="evCHDaXM"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66CNUBL63863301
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HqqOZmOmVi+XVHlGNma//JaIAhFplFOGhvKHJnsNboM=; b=BoU7XLjCeb81bmb4
	xY5AjjBi9KplMXSESgivsvrUzAoqBq1VHtVtwdBKdDWb1+h+H3Mw8tI70d0tagEH
	lkshQFJHTOo+z5Br00B+M3P4xqHZd72jKAQv7X9fAc+ZF9LFhkIvwmjrN+5TdLnr
	IMQShCT77k09CVxOYIW2JNKIfXOw+i6ptpVk5j9W3OanVa3t5ZViR09uSQLI1YP6
	bDPTkQwbafMCzNmqSZ0n+at5A9l0XjpSYDHgQ6Ke1Il2SWNwQHCqqWTyUqNcjc6N
	j0Vs4XMMA2ROp88jrwj29ZY24XzzBE4dkK/swSgzDRNgBFaVilkgIZd2okQc6S2n
	/bu1Ng==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe913tsh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 00:44:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso1085493a12.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 17:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783903486; x=1784508286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HqqOZmOmVi+XVHlGNma//JaIAhFplFOGhvKHJnsNboM=;
        b=evCHDaXMfzTiAuJOAjd02nEjWJNgMtMX+WsNDCPt4GmdPo9Kn8a3YLhgQb8D1z/3Yt
         iisGt+ampg2NxyPViuHoUGBaulbAFKmGxYlI2AUoaN1hH2kAQ+DQpVfWJ9ZOJuKDcqlp
         oWLJV7Eab/wiuEiPfIveoqQW+3cY3xYvKoDg0ig2qOKVIehTG6/IidWtwqtXXfZkKphJ
         Td5u8k7v67vqFHKa66VURG4KHpvMzMPYacKcEfz2neHf/qWnfBRO+aXB0ISxGWFKLfdL
         5uVGCOkdQFZLYO8SGHQ/V5HWe5SI1aERgiRPuBcs1w0TpbF1h89zn6SMZS4hITIGojvG
         3yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783903486; x=1784508286;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqqOZmOmVi+XVHlGNma//JaIAhFplFOGhvKHJnsNboM=;
        b=i/h0/DTaXBSTvvMYNCbQuXT4ybtidLAcK4h1gEm9B5MOOB9Si1dk9QKacnjXllh+Je
         qQkzuquTtoP4DlvgB/xF7OzMDt9IpWpaMlASthGawV2wRU07Xz77hYn8Kj1VZhjK0uBP
         ExOO2dw4ey8Ul2HeuC7vAbGP115GxBJrch5n2mv3Jun3sYKi5PGktpaADUsTGF5xWl5m
         wNLvdB+3bI51X0EBfDqNpiefSDsS6uEyw5a1aVLsbTzIK0LrD5Ky5IvlCXkzNEuQ+VRj
         /9aMxQycJJfElYtviIJuaxgP+hqcskcTtOl3Mtpm/2IhHeq+9JnAb5DjH1wxG7KenJLI
         nSZA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6qQh1KnGz8yDyg7u1js4Rz5TJtUTkozSqns85ZBoNOe0FL6HyEN/pNveZ5BB2Lt/CJlMf1sSc66w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zp4wyRdj9eAzdJoDPwkObhtdgJhPOlg++fHy5Qn2yBk0Amn3
	G49fj+rjZwGoymm0PBw7DWFZbeWoCZxEFlItv1ULTlNv/hFStmeWRG3AmLg4/xZ8wzzZzGomFY6
	MYTFE//r68reEBpmC3EWAer4NBGh3KsYiIE8wcLw3j2LkDZLc+XX8OgQ4Iyf0244=
X-Gm-Gg: AfdE7ckDlLjJG+bFamED0az4rbA7CrdTYjRSXW5qKunmnUI+r8WTLphy1KnAeHVAqK8
	U+U/OIuSPX8TK42nJz7q775xNoIMv/v/4yWfJwy+j4gV2RQ0xTf2tU7Zx5sWmW2zBYMjUaKXIDY
	ZWhOAz9PBd7qFUBFhWDABA5EpVYrjVemy/1B29PBp4OHt4wrzqmGjBoAfz+g+wzOhZ6JxMwTMOX
	zfkdGieqrP9ItELBPPKAGSVEQeOQ5ErpJJyvq4GoI3joc0mX0VdY8zMKP3TY1oFnlOoCXFOvwNf
	HBDbh1+pqBkxD15+noJBjHNdWwBXvCUhlcfYJoZiin13zHf0Gf6o8xOyGKT2tMSNp56dfvHGh+e
	j1AjmiEnWU1ZLAlgGQz5u7kTGbYY=
X-Received: by 2002:a17:90b:1dd2:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-38dc75d02a1mr6837497a91.8.1783903486182;
        Sun, 12 Jul 2026 17:44:46 -0700 (PDT)
X-Received: by 2002:a17:90b:1dd2:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-38dc75d02a1mr6837480a91.8.1783903485743;
        Sun, 12 Jul 2026 17:44:45 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a55b3c9eesm5689729a91.11.2026.07.12.17.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 17:44:45 -0700 (PDT)
Date: Mon, 13 Jul 2026 01:44:42 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] iio: light: opt4001: Reject integration times
 with a non-zero seconds part
Message-ID: <20260713014442.612ed45d@jic23-huawei>
In-Reply-To: <20260712202451.20822-4-nikhilgtr@gmail.com>
References: <20260712202451.20822-1-nikhilgtr@gmail.com>
	<20260712202451.20822-4-nikhilgtr@gmail.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a5434ff cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=UBEt2JK6THHEFw8g2C4A:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAwNSBTYWx0ZWRfX6DNyw/9YeECz
 hyC5A2Lubsa4+0BlPzJPELAOzOWIkWoBo4fP/+vyPgmJ07OmqtZY2I6T9EC6poXBvPhM8jYW7aF
 7MbymMCBxHUVUsYCSK0DfMgbwpDpHC8=
X-Proofpoint-GUID: 2JZfahg3MuQT8a0ZNwuUOYAQHXNFBZ8A
X-Proofpoint-ORIG-GUID: 2JZfahg3MuQT8a0ZNwuUOYAQHXNFBZ8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAwNSBTYWx0ZWRfX+hvXovUtpb4t
 dlc52Z91DcInoptkj3aVMB0sprAmfktu7vVrgeFziLPwLGqljz2OydRtJA2QL3cC+9i+xktCbis
 8tw/Ht2lenWs3c/je+4llrXExIqvxAIsgd1uCVLkr+2EztFza5lrdBcGTgWwBI0596bMgfFsBRh
 45QGVUfnX9xl7Q64wAkHgGMCKWf5ikoT/LpUxiwVD3qeSDFnYJwaZ/bnj0biMpP/pioWXflWxIZ
 ATKSrDFdT+tCzpNyMdhf8i/aEvynEV2fSciIufgFFhpn71PYhfS++3nQhg3bn9Gxf3gl5ISYN6v
 6JbsiUlIgg3dd65iEDp089IoqVlax4OUEuLS31AbWcRN2Mdh6nvTX1BLtMTQVrvsdDCnS0NfpLO
 hG/DjP1ekwmmjlToxvZnumhFRvmEDshdCmk7OB62Gx3Jzp2tp3RbRdMCV7eEg5X4g1V6K4VLyMq
 uVokzx+3Z8rFQSaFbgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130005

On Mon, 13 Jul 2026 01:54:50 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> opt4001_write_raw() only looks at val2 when setting the integration
> time, so a write such as 1.000600 is silently accepted as 600 us.
> Return -EINVAL if val is non-zero.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Fixes tag definitely makes sense for this one.  Good spot.

> ---
>  drivers/iio/light/opt4001.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index bdb1eadbd450..31a5397926eb 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -288,6 +288,8 @@ static int opt4001_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_INT_TIME:
> +		if (val)
> +			return -EINVAL;
Blank line here.

Otherwise lgtm.

>  		int_time = opt4001_als_time_to_index(val2);
>  		if (int_time < 0)
>  			return int_time;

