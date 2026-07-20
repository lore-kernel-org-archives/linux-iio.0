Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE631624C5
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509111; cv=none; b=pPHnbaKIBXmRYeW0T5G2d/A3K/oL015T3VnMi+xqYn9faFd7Cp9FRKeRZ2RJ1kjFZCTEndXSZAZFh+j2E95PjeCdkS3XkTJanJydUItYsygrdJcKy2QQrFZCmNFNXalBVEdMOdiUsUH9fiWCRojpXIBcgg4uesjwywJqKTDqVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509111; c=relaxed/simple;
	bh=UfMxRsnOoAehwkOh0RFhkzyHR0CYrSyNtCXREQkkjMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iigjdGH8EzyY6Dxmgl6pfHrGZW8uYBbPT0X3DQkt0S41i3r/mZVsaShyxkkDLDNLLGpDCYfNPbtlCDxQmomdPmrxLSBcs8rHk/K7I6Vw9WSZZDZ0ZHVUFzlqeORjnX9RVXiqfsVRrqf8oXQXejxeOfwecy2UvA9WBgUOevoUBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9mpaHce; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dGOmtngt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9mpaHce";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dGOmtngt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JNst8h645579
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xiDk4Kx2knDPDiUKLpy9BhcRDBcBn002Yb9VrPVwBJE=; b=W9mpaHce2tmcNPop
	7Uaf8HFRK0btXP/T1fH0QHHps8bAYH3pLgan0kDsjK5voeKzCk2RHQtU1mIVLxaN
	Hwg/qY0Xz4p7cV8Z4T6Q1KwmHYgdhhbZb5B4p1Q4X1mGQLACTmiHzesJ3bqFoK04
	BvRiCt590DGOl+q5pSuJ6WD3w4CLyMMBT0ZpAGWsNB6lpn7DcObS3mMvk5fvRtRG
	t/VtrMrBj7yItZrP2jDcrvfTLDB3GOntaY/PT1jWZWMYhQVq6BTzHHl4mfUcPZXV
	GRYVxc21XaoV60p+n1xHV1sgnaib0aK5U+F0q5r/tWYE7bbliQNoSn1OyJJrRnvu
	naj+3A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvutch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 00:58:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38c7e26ecabso5925775a91.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 17:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784509109; x=1785113909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xiDk4Kx2knDPDiUKLpy9BhcRDBcBn002Yb9VrPVwBJE=;
        b=dGOmtngtN0AUbEDhanaOP5qffOCGdBpmRmDHgsM4zaLTJU2u8fgDix+G8SILI29ic6
         5ZqJeV9LquEDCCDxdYhTGJ8coFVJ/o6HO/gm2vklEA+6zFFYf8ZbTMvC8VzNqyQCBGvg
         RExcTf3LzDZZ37m5eZxvc7E8E7cL9VAYgBgpMIrCXhIHoX7f0ih8dNQsgT7GDdXxsUdF
         FLXm3DruNhJdpdeU8Ht1dId1+RhsnU8q3O4s29puNNyL0kKcmu9SRx2DgivjDOKP9Ioq
         CVI2/FQDFFPe6RqlWDDDAef3FfKCQi8GppY0D1nnSHNFABTYdaNybPnTMVe4t4C/6+BH
         +p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784509109; x=1785113909;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiDk4Kx2knDPDiUKLpy9BhcRDBcBn002Yb9VrPVwBJE=;
        b=LDWeOH7UEsM1c0eU4mBjOf0gBsU97nwve2cRo9dyVEWYmb1AZn7oCegYEL4b3qoNEI
         kE89cL6OLBoiR5ZTjj9efFj91pE/3cplhMUoMpZvT9Zo3/QhnBaULS7p9Ag8Q4VswYrm
         0DLcfUOLfgHPVjQmEp5AzlqFyIB9TOXCIUb9V+mXeTcWh/eOhl/ZYf4MYE8ONLKqb8dK
         K2MtRt+ozhl/1U5HHg/PdRLCvqeMYcqvXzL5/OXyke64WWGXuPmUaFgEtZJLvJlZ9JRz
         BlpNvgSEFh80sR8+KwRSJuKwiiD+fx0MXSavLfhEoJ0bv10Wbg4EJU5Sw6Vn8HkRrG+g
         6FTQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSiff+do61t3qTuFZs5FdW/nF0fanqZ2DcrmpK/MmG/GTmTf5qpUkfW/T6rbkLsH1cbp32JwWonEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4111wsjMQhQEtWQN4azV2cA0lgjkLyNSxPvChUC3ahkIrwBN
	s+zreqQaAr5uQYtH/AI8upLTor/1Y4Kzd4+8bcbv2JXEVWf/bIXJTVrIez0vhJN6+DZybIbDxsC
	nzRWzYk47VZ/VTn/eMLnVrAq8AUjAjbNTVfcbG18EJujNwcTWybUgfJrgjFXo1T0=
X-Gm-Gg: AfdE7cniLVIOdXHB2c7OCs6VECrC2FrhSNH+Gux/gKPoV1n+51h09oAqfGZgJnhE4sy
	I6PjzeW4JAZnWhhLJgXiVeKsbRgdD+TvzDNe8g3mXCTdqIxMhaRebbEb+c5EDuRnmqZvrtdDLEz
	cgLCwaorbxsZFO1omCs6n1YfMByvL7nt5cqU3AFLlEJ29BhErgBBlb7st8HDvzbVjRRIHWCu6cp
	SvPRgKxh/M0jlyOq3cVUPlmHK+fYScZeHSY/Ep/kR2/Xorj4QY+MQaBOKGzGeGH8jqWUkWE7+w2
	ddsMfmwBz1Ls4AwJgrtWqAvY0IkWnRs5k8k0gs/hZlg+umBOQxYx25IOW2SySqrSA7Qb3VcbUk/
	/wW8EC6Nt1tBX7xNY
X-Received: by 2002:a17:90b:2f0f:b0:387:e0db:bc31 with SMTP id 98e67ed59e1d1-38e4b56ed5fmr12407920a91.39.1784509108786;
        Sun, 19 Jul 2026 17:58:28 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0f:b0:387:e0db:bc31 with SMTP id 98e67ed59e1d1-38e4b56ed5fmr12407899a91.39.1784509108343;
        Sun, 19 Jul 2026 17:58:28 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4b22c0c0sm4759092a91.16.2026.07.19.17.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 17:58:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 01:58:23 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Siratul Islam <siratul.islam@linux.dev>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Luca
 Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add QST QMC6308
Message-ID: <20260720015823.0b1e62f3@jic23-huawei>
In-Reply-To: <20260716141800.82761-1-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
	<20260714202842.340293-2-jorijnvdgraaf@catcrafts.net>
	<03e59d2907ffccc2cecd94ab44d19359f2474733.camel@linux.dev>
	<20260715204616.46517-1-jorijnvdgraaf@catcrafts.net>
	<989a9b6a2024415ce29c1aef162c6a4d341dfa45@linux.dev>
	<20260716141800.82761-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dL_1YRfXPee94q7hyqxyZxvA7iPPah4w
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5d72b5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=GYSh3LzNAAAA:8 a=FBOe7vr4YkI6Yy5QZKgA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=lWcdFasyL5yHfcDTNXXo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDAwNiBTYWx0ZWRfX6+eO/cpCOqvT
 qIOX5Xw9+duADExf+v85UEHUSLeLcIbuQCp4GM7Gy48K6GPJOR0nvn7AC0OasabOP511VkaqNY4
 1RAC+0YqVmdtuVyjpNsJS0IBOfvnZ/Q65KytNX0dHq9kcWUgtV+Elj5LocpeNuLCWWSPG0FSooJ
 qwyZBlFzPYmKflT/zryAcNNg2qj+vbrohCQYbNnruB2ogYMVEQV7aazo4dnO3ckltfICZPc+/l2
 SqxUFjYa3j7luN4xhjba9bBauwB2nYVsIY9R0iCkRhpdG3ylyXckbEIyRUL+hmbZnvZBiDWXkqc
 5yViPBElQ9JjyyLkvwPHnywMDG4FJjcUxfPA54ypfZvPOvhQmncgImEdcnwh0/IjPoIhPTOcQy1
 yX4mO66ZxXn4Yr36ZYM+ovbBN3Dq8Z+Syb9C83zJyHaohaDC1tPmdf3AyPa5fFWKxPreMYsCK1G
 MRDYBcwRP4HsohvlkOw==
X-Proofpoint-ORIG-GUID: dL_1YRfXPee94q7hyqxyZxvA7iPPah4w
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDAwNiBTYWx0ZWRfX79WsqbwTwZYt
 tSKMv/tZMIPy1OOj2+/lYjIFu1tVfBnat49+HR6I2RXAK69bVOYc5QPrsr+2P0p7i1rZmeLf8ey
 n3RCiXDmOTuhUxqGRHF8jCSpmyGeUmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200006

On Thu, 16 Jul 2026 16:18:00 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> Hi Sirat,
> 
> On Wed, 2026-07-15 at 22:16 +0000, Siratul Islam wrote:
> > > I'd lean towards keeping the separate file.  
> > Wait for more feedback before deciding, since you have a few days
> > before you send v2. DT maintainers usually prefer reusing the same
> > file where possible.  
> 
> Right, my previous email wasn't meant to lock in a decision,
> just my preference. If the DT maintainers want it merged in v2
> I'll happily do that.

DT maintainers may hold a different view but to me it sounds like
the overlap is small enough that the complexity of combining them
may well outweigh the advantages.

Thanks,

Jonathan

> 
> > Register compatibility is driver specific. Bindings are only for
> > describing hardware. So if there are reasons to use separate
> > bindings, this isn't one of them. A fallback-compatible
> > relationship isn't needed, as we are already using an enum to list
> > which different sensors the binding supports.  
> 
> Fair point on both counts; I'll drop that sentence. The lack of
> property overlap is the part that matters here.
> 
> Thanks,
> Jorijn

