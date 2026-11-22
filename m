Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795307951;
	b=VPJem5Aysn4EDQI2eTsjFbnVozbg3aCW2AH5cpFDHNbYc/waYr7lhso31rS49AO39EK2
	 rH1kYQNeA15StKaXY8gqGEDF9g13EaNJO8R8OnmbQ2dVT6ImuW5KXID2l3/oselBZOliC
	 Upcp/1djZtOyT1D/NMP2veTjX+ANK4t/Z+LamHvJbynKNkSrB9rBG/6vsyWT+SG8J5pMT
	 iZRNJ0AiPXsl3CZIgYa7muAnN8wrXr6jTlK/p90NTtdksxnCAUDD06nSsZW4DEACEq4qw
	 5pEev/TkBykGSe61Gxmw9+6xxc5FznJxW0UJ1PXXDeWWXGqOwl8RTPBD3FojBJC21/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795307951;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JNNgl8cJrt7awDwCy8ZoltjIRpmSrU/A83ItQJycB14=;
	b=EVi5UF7dQRWUbJjNAKX68wpQa3wEqHsrhEz2Qw5UhpcrkfR6gEdkpOfFIdIIgTXZLlNR
	 ZMirHbE8/jTGlNb9aYeF3bWCCCO6Br5DP+Ui2uljppeW+D/L3acW5gOl5ffEinQ4k0VRK
	 6z4QqrB9Yb/lBSnmg8H7jVwDwmjto5Q31OVxVb1BjtqSxHWmToJSFayq3ibCOnFTRk0Zk
	 DIT/T85QGZ3+pIedswPemkDko/TwIhFZ9xuOM0OazqAVGDscXf39J5Y/PDxkgCxgXiK+M
	 4sncFiAtJ5KxWvVTPf7mfDyPUca7LOmllQsXr8SJmq4RYXIrdaZ7myK1oBs/mdpA+SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gWjo8T9u;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FYn7Yo+8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3173606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 00:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3173606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gWjo8T9u;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FYn7Yo+8
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM09MWB3599771
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 00:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JNNgl8cJrt7awDwCy8ZoltjIRpmSrU/A83ItQJycB14=; b=gWjo8T9uAJMYapwG
	Jcb2lPqNcjEQVfd7C1EMckwiBUtj63t7iOdflbgcAvwD7cHN60RDRnbYdJ/uWhdP
	ao8zNge7yDcHd79R2Nm0o9DZ9lCX2G8P7eX/QqUHenfW8na7i4LHDwzYjmR3++Ag
	o1GQfKQPVNnsg3DqZkuB0zABq6SABk6315BDNivXw0CyfpG7L+Eri/7cbSG1tvGT
	Jjn8qLOlVM/aKJ7UL6yIqxjrRD96pHzcKjQjk5fLsOqTi8gaSlqKyRMoMh9PQuKt
	5rQ/Enzauk9YqdXpnVJBAzRAyfJtca+2zbFNdUs4VuLa9dD+89lxrA4uFRGHLASV
	ndxLSg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32w02d31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 00:39:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb96533adfso1289735a12.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 16:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795307948; x=1795912748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JNNgl8cJrt7awDwCy8ZoltjIRpmSrU/A83ItQJycB14=;
        b=FYn7Yo+8tyhNvvtsyhT4ThnLm+hw0XCaRJxj8xbNZqxpD4Rn9/mz8sKCnW9zsJ9Xr2
         8brRsbEbY5leZpfJ0iywOOXnW5QDfA6u1bND63BFcQB1Z9teNQJ3+35z8du4jXHc/phq
         lGY1LeWijdLCPlAtncngNlge+0S7MkNTNzQ9DSBfTpxsZ7o4Qbn0wNk9OfDDrnnOKFME
         B3sSjiA6EUDJNpj3gbZbFq9wz/0JlL9EwRcAqi3S6/XuF1RjrTAsV0az9YXKKSmWvNrz
         a2T/LDI/U6cFQgLSExTeBCV4g1v2QViBh60p2S2feCGBrDFO9BcoxJja02rI+21RIBqB
         D5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795307948; x=1795912748;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNNgl8cJrt7awDwCy8ZoltjIRpmSrU/A83ItQJycB14=;
        b=wWmtc9pdlUA5/ime8BJFyYE05jOnuw4KzdK2t/fFy151LX2eTc3xJhRpOIkaN/BbhK
         A4+fEq3PIIRN1zhmSv8OonImXO//y06teyW0xC6fkiAXuhqupBU7olK0++2Q0O62d3f/
         A9XSyxfwZgi0Zr75b5So8yXM+vMIzJtTs5ANqgX/EbrPUYLNPMVtnv2PFrW+FKPPjTkl
         a3uXA9/HekukNHrlmBfIW9BWHD654FoZ8vHeY1zWlnOJ/B1YL7Eg1SBTxersvlW/8ZST
         9Vq61sYT2uctTL7/T1lrsb3Gi3LGN2yIZRaRA/Xme1/6kl5MnOZdB6daNFe0fo8YQe+6
         oA+A==
X-Forwarded-Encrypted: i=1; AL+hErFMKRc6o3H+dGqr6m4bg+Okt2ASa2q5sE15UBq1PP/8wSJ10UEjBjQILEZkg5auLoTvfKagslUa5h4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UQ2Mns6g+5/AIQ58t8o9H4vB20uS7TlctWYgq6Voi/APDABA4
	LOrwvS4YkBVJoU6vysH2RIJtLppYqvscZz+iZ5zfmG7xa211UlD1+vBS6S1NjIqrCfL717nuXUi
	5ou31TEaoM3zO3EEfcMUvT/KzbNIdzUix3+FYzEBCYNm0Bpk5yDn2RuuhxHg8BKY=
X-Gm-Gg: AZFdTZeRNmsD7L+1wuJeSImuybO9Bn1xe6hwQ7drDvqCwnMHvEH/Yqh/u47SLvtvaq8
	udr83uk9Yn337zgtQASFlaAf8LHCz+PlaymHWrWZDwnOflxIQp2LXuSCs9Q7umnqLHNEzZWnetO
	P4kZYL1FGLXz3dawhIBxdxsnsSt0w8cQGocxAKcbpx1phsEMAkVbbrvVY0YGF62RDDm4pPJFje4
	DHvlxZvmC5CEdplPwQYSpfl9Z56KJ08onH3/chyw8+q8GeK4HpQvlzpzFJDHzUqnf7Hj000j0Jg
	9O4UcSzlJLur7BA+h8geyiK2QUirZnKUScjnJnHeL3p2oP3XzHHovyMUmWr7Ey4bWd+hpa0jiI/
	zWVV1s+j25Q197hvyo4S6bd85BotYUO4oKy65lQFSjApkRvo1urvY9mXPeOM7IMphEsU=
X-Received: by 2002:a05:6a20:258a:b0:3e2:b295:766e with SMTP id adf61e73a8af0-4014d76148emr7351963637.54.1795307948437;
        Sat, 21 Nov 2026 16:39:08 -0800 (PST)
X-Received: by 2002:a05:6a20:258a:b0:3e2:b295:766e with SMTP id adf61e73a8af0-4014d76148emr7351952637.54.1795307948032;
        Sat, 21 Nov 2026 16:39:08 -0800 (PST)
Received: from jic23-hlaptop ([50.35.44.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0332bfsm3074734a12.22.2026.11.21.16.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 16:39:07 -0800 (PST)
Date: Sun, 22 Nov 2026 00:39:02 +0000
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kurt Borja
 <kuurtb@gmail.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron
 <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: light: opt4060: Remove dead code
Message-ID: <20261122003902.7ff5613e@jic23-hlaptop>
In-Reply-To: <20261118092400.00005465@kernel.org>
References: <20261117091006.1452131-1-andriy.shevchenko@linux.intel.com>
	<20261118092400.00005465@kernel.org>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAwMSBTYWx0ZWRfX9wZe41PunpvP
 ZqQg11+Hh2tcF2DySv58Z354+4ZlImfGT723+SrHq1B2yNxIoyedKkRwh+WOa70ubIMJwjyJLO+
 CSkxKzTcoQ0vH0vZR7v4i9aSlXMeZeYfirH/wS3xLvbniO4hm+7h0s4cwNV0w21JCZ8Xm0rXQu2
 aSyUH/CdsCdHWIZYIws2nN8rvZKYnRjTrBSBdw+zF1CDftTKlodW5xEZ+y/KEH8kGOXY36YUYPE
 /19FzcDfPBnQ+cFGhpvRBbWF5Vcb5ivNkjuIo0fZx2vfYjYIioy7S14+PWZSScsV/kYT4bi8eex
 f40/6eTjLtjLjprY0FA66uI3Lv5WU5LL4hGHZ/uQF1HxUDrMn8UPWX3H5mAmBpnyGAzk2rmzwe3
 oGo6ojfbkq0EfXoJyyg+BMeL6fYNbovgREh4cmdoobuhhIRfRRNaqB7VbTrTbj3cmH6kw2t+TM1
 k5OBE5iRtLiBbTed8dA==
X-Proofpoint-ORIG-GUID: f2ANjIdk2IXi_hgMMFabdaw_TSRqPFGU
X-Proofpoint-GUID: f2ANjIdk2IXi_hgMMFabdaw_TSRqPFGU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAwMSBTYWx0ZWRfX+LLsPUUri8me
 k/aezZP//xc8ipMPV5hI0DV7i6Uz/ARZEqRu0RasB1Q9+Qq7b/crHBVpDUO7dF1La2fRIEnbYti
 ASUUoH676CTK1jHl5fKmUKbPev40BwY=
X-Authority-Analysis: v=2.4 cv=S+dMU4sP c=1 sm=1 tr=0 ts=6b0239ad cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=aNnz9XPx1a4JIXSYt2cE/A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=DgNfZQOBbNvQCdoMCLwA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220001

On Wed, 18 Nov 2026 09:24:00 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Tue, 17 Nov 2026 10:10:06 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The struct opt4060_channel_factor data type was never used. Remove it.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---  
> 
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> 

Applied.
