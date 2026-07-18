Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35C2D1907
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784416749; cv=none; b=mdqj165BwIJW0wdIJUgBo4e41n+jCU1AA+b1ehkn3dRvgCMji315IuN2XSApe9GVHpyr/DYefaOyO/n6p66KodCl1q3UDZUDYVGsUrN/+DaVZn8pLVMbvhKBMSpVu/4valA/M6QFoCwVHTGcDD4XPHXFOkv0hg1G3HDUm4jucoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784416749; c=relaxed/simple;
	bh=oTAbK977qB4/Q5mPO8to8DKHkighS9A5v0zD8qSCZE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaReD+NyRXoWXQ1woMljg6sL4DdGzhOUxs0qc+1a9rhwjDbSfEm4LCoO8gR991MNFYCp0gmiVZ7oprvXqdRy9C0E44Y3i/O/qZhQ9tc+uVu/mjIQkTS2op1979hGmbw1WI4Li+StEuV4lTGREqWUYTsremMDbGLguYTmUQPcNSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b+N4z26U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IR4fbEw1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b+N4z26U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IR4fbEw1"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IN1xUJ3059136
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wixpu2kchuiVCtWTEBuCD9grp0pwB8m9u6bmCRDtb/k=; b=b+N4z26Ugd8jFgPw
	pH9UdUbLhENi3IJxjAvAwydUlAJBZ7RV+vlAqik0hAGZzK9/UgiPYtfdMYTBDHO1
	7FIdNNMYF6RsNCbPUO5XO02p+aHCIvEGwI2MrH4gmWrtjfp43R6JVqOvKq5vXvjq
	k8/In88xguQXOK+whNnbyCqJx4Pz4dof/Q3aoArLGi2qHKhO4fda+IEGawZWDgRz
	J/K1q5U6HxNSXvuFBi7e9ahQEyClO/GTUC+1yC/x4CHCn86UB1zRaqccsPvCC4D7
	CoBKRdN77CUi2I6RL8XPpxs2pkxbKW+OdzU5NRuB6XcqRdud4FJjEsyDKtmzBcmO
	tRj8tg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aasqf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:19:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381250979d5so6245548a91.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784416746; x=1785021546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wixpu2kchuiVCtWTEBuCD9grp0pwB8m9u6bmCRDtb/k=;
        b=IR4fbEw1uanf/GJK0CYb5OqOZBKtJzpFydbjQ6okxmiM+uncaaW0zfZ3t48T4vvgAZ
         TGl1oy0x1/XBKX+3j/yf68/qhj32Ewq/gRHQRbzII9baZLSpywkMj44v739Dbjl4EVzy
         GwwQTt3B0s92sa5Dh5H5tXq3Nqm9sgjK/YUkMhgjTIKWqUyzaVfkhbFXBR23uCdBrEi/
         DDyfkAiDjnIQwFROIrlAL0RD3+FxKRzkNZukxpE71upcn/aUoBWOYwskJeuzNb8sH3NU
         kuIrJwvU7SYmHxteGBwVIKfX2hFizYTlfzJ+AXTwGELSPI5M6lVOqI9kckYKO+HFiNok
         QLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784416746; x=1785021546;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wixpu2kchuiVCtWTEBuCD9grp0pwB8m9u6bmCRDtb/k=;
        b=XpEvDDTlftgQcgjMfZ+Vu3h2iOef692dJLxEy2LpVZVzeroGxnJLi+9zKqzAzYV4Ac
         ZJkZwRyWogaYC44XBUYVIJt2dxsjNIzwW9f7Pyeq4s/mTcB+Aw8el2w0SSTeanmm+fWb
         ivSIhk0j7Lstxv+xxowIpOuVY3gd62Hgd87RtXh8rdyBun1ceQM9y86/BoL6Vw1KJA/p
         STOK6kecSvKtM8ks6QzlaT82DDsDBUti/bvEDfRduIRTZw582ab41ggtL0htRxFhjyZp
         IIZzXD8A3zH7n45fdJXeLNT2/FotNEPS7Whry46IJoCIHIJVt64XnARRnfivhL463rmJ
         Pc9Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro9xbm5P+zBSFOnmQQO5l60Xf34nX1/LcxFtzQx7gNmG0ynrffclY+a2FWmN/XAc7mBE3NxK80l560=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82pQPhzJJXLIcRpk/gCn5ljuwdNSvW3wKspl2sqkiNRGQ+5Z0
	yDuccocoEor+yEJL48Pn1MLHZ3iEXew9vtX15OkbQBIw/JjOEeCBDnevbQ7lvXfUccKBmqItnH4
	gk1/01V0l3lA5hUJwfnt/arPrRNxx+eGy2/PUMGLboU72cAjDqa0VMQEX5zIwRV8=
X-Gm-Gg: AfdE7cnvTViByeAIKHBWoM7MHIkVGtIV/eIju72W3ttYBF63/Oy53Ai3SVinbAkJlLm
	PajNs28r4qVcdNA6ndLAM67oYH1qP5U1f0W8iX8PnCxHtUj49WHlBZJHmkoU+84PkS7e3p8FJNV
	OOwN35x4R4Mg6nCM5vSuRo0P3vskCQQ5h9qzsrskoZqtUwxoPbeE0Woa5xe/WXcB+p9n1r//I9v
	mPPo6SWuPx59SqtDcs06GZ/V6LnMI97N5pPNAPbyjJfji9EASBXZWr5qx522A9Kc3VrEu8bs0ee
	CXkQXL/RNmJM+wCajMq6Jw9D6IICAECf3nA5JflEYFGoy/xaZE626JUwJm36hwlUNpiEmvZy3L4
	fRkbfUcmplksG1kbI
X-Received: by 2002:a17:90a:ec88:b0:38d:adae:4866 with SMTP id 98e67ed59e1d1-38e4b516544mr9060528a91.21.1784416746440;
        Sat, 18 Jul 2026 16:19:06 -0700 (PDT)
X-Received: by 2002:a17:90a:ec88:b0:38d:adae:4866 with SMTP id 98e67ed59e1d1-38e4b516544mr9060496a91.21.1784416745955;
        Sat, 18 Jul 2026 16:19:05 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4ae14a32sm3377126a91.0.2026.07.18.16.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:19:05 -0700 (PDT)
Date: Sun, 19 Jul 2026 00:19:00 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Chris Morgan
 <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
        andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
        jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
        krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH v16 02/10] dt-bindings: iio: imu: icm42600: Remove
 interrupts from required
Message-ID: <20260719001848.435886e0@jic23-huawei>
In-Reply-To: <PH0PR19MB99733836951FBC9755A5361641A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
	<20260713215842.69097-3-macroalpha82@gmail.com>
	<20260715-mottled-uncovered-mastodon-6c08be@quoll>
	<PH0PR19MB997338D80EB8ABB7C623850A23A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
	<82e3c736-f06f-484a-887c-9e156cb7cb44@kernel.org>
	<PH0PR19MB99733836951FBC9755A5361641A5F82@PH0PR19MB997338.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dCkKFTRnCmKuSxMQQCh1ocj6oOVk4uKN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDI0NCBTYWx0ZWRfX9ewviPhD3dEa
 WYuLc5lD2Geu5BrGFNMqaEyG9eqqa9NAM9AZQiETRi4zAX8yexZPhiNhesmLmcghfxT4ssHQ4x1
 pAc/kNZWWBdnczpeGFqnrqxkezeEfo0=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5c09eb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=69EAbJreAAAA:8 a=74V_kGC0JxGC7Umba8gA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: dCkKFTRnCmKuSxMQQCh1ocj6oOVk4uKN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDI0NCBTYWx0ZWRfXw1qITD7Dxn71
 6tpBx1yttxpyOsBDiezPQA1a89EalPuzGL8cSqQg0WTXQaZJ1Mrfu5k+qAPIKBGLo8TvMA65dk3
 vqn/y/rtwtI8MZ0Ech0FjDYKaZl2z05VwgB6ZoF/gTEo42RZ3mtQktUJDYIWrphoB7jJWCluZWb
 CXGArgOrvNM+Q+Pe0dmu+wFOUDrxxe80zG6ymJs/AeNv6U/LVqW8tL/j+HkxIqg2+Cipt0zrvnA
 mICLGp9wl6JNs8rmGdt/FFGWPd/8oYTQnKcregArLHAiAZhjOlYfCTaTYSi7VdlmOkR++7SrVaK
 Hf/UVGS5uooerqeuLSNRkF6xgxYiBkWn8NnKYNJZtZM1cgjBl/RAxU0Mb/FPkqNOvjYe74qxYUE
 +qTYn71IJ80TbM51yEiQ/UNWbMuIXHw1nIXDQCQl8vZJqOxADzW9h01ZPjuZHAg0Iegr9tJ068H
 8qYjokuhj31WLG9s7LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180244

On Wed, 15 Jul 2026 15:34:53 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Wed, Jul 15, 2026 at 08:29:44PM +0200, Krzysztof Kozlowski wrote:
> > On 15/07/2026 16:52, Chris Morgan wrote:  
> > > On Wed, Jul 15, 2026 at 07:52:52AM +0200, Krzysztof Kozlowski wrote:  
> > >> On Mon, Jul 13, 2026 at 04:58:32PM -0500, Chris Morgan wrote:  
> > >>> From: Chris Morgan <macromorgan@hotmail.com>
> > >>>
> > >>> Interrupts are almost never required for IIO devices per upstream
> > >>> maintainers. Remove interrupt as a required parameter for the
> > >>> devicetree binding.  
> > >>
> > >> That's an odd statement. We do require interrupts when the hardware
> > >> requires them. We do not require interrupts, not because we have such
> > >> policy, but because hardware does not require them.
> > >>
> > >> Plus, we do require interrupts when software implementing ABI requires
> > >> them.
> > >>
> > >> Above commit msg is simply inaccurate and misleading. Instead, please
> > >> use actual hardware arguments or how ABI is actually used. You must not
> > >> introduce changes to ABI just "because" while for example making that
> > >> ABI conflicting with existing implementation.  
> > > 
> > > I will defer then to Jonathan on the specifics of this, but from what I
> > > can tell:
> > > 
> > > 1) The icm42600 devices don't need an interrupt for operation other
> > > than for buffered mode or wake on movement. One-shot should work
> > > without it.
> > > 
> > > 2) The existing icm42600 driver does require an interrupt however, and
> > > refuses to bind without it. The driver could in theory be modified to
> > > not require an interrupt though and skip using buffered mode and WoM
> > > when no interrupt is present; however I don't plan on making these
> > > changes at this time.
> > > 
> > > 3) The new icm42607 driver I'm trying to upstream does not use an
> > > interrupt, because on my current test device it's not even wired up.
> > > On future devices that I have with this chip I may pursue using an
> > > interrupt, but it will never be required.
> > > 
> > > So should I go back to requiring the interrupt for all devices except
> > > for the new driver then?  
> > 
> > You mentioned two drivers, I don't know how does this relate to them. In
> > any case your commit msg is inaccurate and not a correct reason to make
> > a change.
> > 
> > Best regards,
> > Krzysztof  
> 
> I'm confused, so again should I just go back to the way things were?
> 
> This binding is to describe the hardware for devices using two distinct
> drivers, the inv_icm42600 and the new (that I am trying to finish)
> inv_icm42607 driver. The hardware requires an interrupt if you want to
> use features such as wake-on-motion or hardware buffers. The existing
> driver inv_icm42600 always assumes an interrupt is present and thus
> fails to probe if one is not (making it a "requirement"). The new
> driver I'm writing does not use the interrupt, because I don't have
> one.

For dt-bindings, look at it from the question of 'is the hardware useful
without this interrupt?'  Answer is yes for vast majority of sensors as we
can either reduce features but still have some useful ones, or use another
approach such as polling a ready flag to replace doing it with an interrupt.
It is very common for boards to come out where none of the interrupts are
wired.

The only time I've seen that they are actually required for IIO stuff is
for very simple devices where the interrupt is the data - e.g. stand alone
threshold detectors with no ADC like functionality.

All this is independent of the driver working without the interrupt.
It is fully allowed to refuse to probe because it relies on something
optional in the DT-binding.

Jonathan


> 
> I'm thinking I'll just go back to the way it was previously, unless
> Jonathan disagrees. The interrupt will be listed as required for all
> devices using the inv_icm42600 driver, and not required for devices
> using the inv_icm42607 driver.
> 
> Thank you.
> 

