Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB78258CE7
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784497700; cv=none; b=cCfb268sIc6sj4U/HbfRqXYD+SqcJC0+i4+BLlZhdEMVTiZyxghF3n8K47Ra7YmL88za/8dnlt4+mJB1vfYMrejnMXJGxZBY4DTtyy5sermjx+UeiuQXPmjQLjct6oVHmuc/UrAsJkSD+9JljaJcYueIBnFG151YTO/IsC68ve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784497700; c=relaxed/simple;
	bh=I7egV33loC5TghlanC7lY2WBepK/kxqQizE1ePCx93U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYRYaLZy3WwC3b9zfCJkVFz1+2UyNvF27tUWV5lBAKUz/2rYG/9WhRcoGdG3TnCCdMUFhA+59QBsN0WZAIOkjk1bq9Rp/zngbHC+jaddNX8lfI5HqnvvHkVvIo2OOEA/FJrRNcqzlynUbtRysXR4+N13HHyelvwgKp/zWHnn0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ds5BIU0P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RzA7jHYs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ds5BIU0P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RzA7jHYs"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JKRHge334495
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ucz3bZP4SDTMDnrZ1Y1tj/ADwQW9wB/tT5cwiPbfh5M=; b=ds5BIU0PWwzcOcZi
	U2u5tCKg3w9uWG8vxIJH0Tsbf2ux25U9ECmMEKQmyb7G6IgJ20E2ylbP8+Q/Hhrj
	3BFA5cPj66AkX30hp8BHXr8VCAP4QT45GVBBCVOJn2p/l+fusE09CgSDxhAFHk93
	MqlRvLUFs36dZpTlcBXwtaM/hrp9zwSUIl4S/fImr03zXZbwW87MONJnHtsFj/B/
	RN5ASBTG/p82B/iz7Rbgk3xp8TikyAIRD04zNE29syz6qi5AbzrOyI1i9bXTIrhL
	DDVDXRkBDcYzlX7Bk4DWBVqwzNubAodDsP570M6yz52wZ92VJOHNpGc6oz9NkuPT
	weQ7/w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bnkh4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 21:48:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848860def2cso10285891b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784497696; x=1785102496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ucz3bZP4SDTMDnrZ1Y1tj/ADwQW9wB/tT5cwiPbfh5M=;
        b=RzA7jHYsOFDFlG7rL/wFAeVh8KpEvG7XT43mOh0lpLUt/uBI8BQzwdURhum9+5RQ/C
         nAy6UzaGQuv9gwh2PN62lJcldG6IYFN35hrfZACO2Ql3orXQ1fFd9TGkpr7KWGKcemCX
         1Ood86+wCcSrKz8kIw3k+1K0YEzZMRVYxF6rSYqqOSL6JoR32erx01W+ila1PuP9Q53L
         KRUYoDpHMDXwLY2oIu8o6V9vxsgxq6M7T4jXjRrwc/PcbC/CzWqIs7hN2xeXbUfl4bOa
         Glz+wA/b03lxKBOXknw3fgzU6/upaJY+z5QSrg5BX0GIXIjBl9CEr7ka2ViKA6pt+nMt
         7Kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784497696; x=1785102496;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ucz3bZP4SDTMDnrZ1Y1tj/ADwQW9wB/tT5cwiPbfh5M=;
        b=MCF1vhHtbpFJ+IL/OItitdGQIZRfWqvxgn8PBEgCXdi2MWrsGo67Z97Uov7okt6a7j
         tJOewyIc+yWdkNxdyDcBZZ8wgMdnk1N+4srbdHUgMkKuO/7EmAfIp9X7vtzYrStjBsvq
         rTDorTDVi8KZwtO2ZfH+2rsekEqbxzaQ8bAjEvCLgGNc51QgbAdRhOQFuOxRgMoE9a1I
         iEuRWRZMmGhqPyIAr7OiHm4L8uCKg769ge+CQunuXOdMHBs1WizZmW/EuJM0mG0och2T
         XWxi/WCSkCiJBGLBiO9UHlJKTJYovWk1Mu1VTn67pHfD44ZyGC1Djc3banrlCNk2kgrI
         M/Mw==
X-Forwarded-Encrypted: i=1; AHgh+RosBTUCa1TNN4sNa19t2aBV63F6OPnnuO1rQjpdr0nZhrj5021TMLimmD808qiV4pKMOyuYReW/f2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJxsWEK2U5eINsF0DJ6zOTH7tArNpOYuBq0QR6glTgmjZsmxk
	pCaBFDO5DxWHmEBMYI7JXWDOmgpvsqPLVDRwWxzx4+YrhmEa0b2ydHpAZ7pw/sk2gW+wpfns3ck
	a407JEazie0UxMfqGl5SSTLRxinm4rtKJzIxZ9dyPX23O1KZsmmBX3wo1KckDVL8=
X-Gm-Gg: AfdE7cn+QVTwgieofR3WypnM47gVv/LcYHYuS+U27WSpmlUiOQX87NdyxKj9+F/ZZN1
	tfetrnirBy8LCq6BX/q3+RtaArgMSsCaSSBGVMcb2pLahXrHkY/S3bbvLFmBerhRKUtTQiZr6O+
	YxvbZ2fPRf5mZAKD1Oy7hb7nNoQ9v8CNFSBNfHH0upkmpM7v5iRdYlO4dmlUxswtqrzRWIfwb0K
	ewTWHekXCTAUxphAJ7WF3OfTAmd+fzpizcUi8iDnAC5CL32jAh5dXA6cA7NLTWWv2SyIMAooOXN
	JPaftNy7NnZ98tWXyDfr5AHGjfiLbQyJk7nnAEXfkWnDTT2XmBI6qxNKUsjsgJGe5OJ520avJyt
	Sp9zrPvQsbM67nZah
X-Received: by 2002:a05:6a00:2d96:b0:848:827b:70f8 with SMTP id d2e1a72fcca58-84c29568573mr10808253b3a.67.1784497696220;
        Sun, 19 Jul 2026 14:48:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d96:b0:848:827b:70f8 with SMTP id d2e1a72fcca58-84c29568573mr10808231b3a.67.1784497695734;
        Sun, 19 Jul 2026 14:48:15 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3f6sm4496347b3a.44.2026.07.19.14.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 14:48:15 -0700 (PDT)
Date: Sun, 19 Jul 2026 22:48:10 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
        David Lechner
 <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,
        Petre Rodan <petre.rodan@subdimension.ro>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Akhilesh Patil
 <akhilesh@ee.iitb.ac.in>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v3] iio: pressure: dps310: add triggered buffer support
Message-ID: <20260719224758.21af4d55@jic23-huawei>
In-Reply-To: <alyPNM21R2PEzkli@ashevche-desk.local>
References: <20260718224455.38acd927@jic23-huawei>
	<20260718235203.73699-1-zoone.rupert@gmail.com>
	<alyPNM21R2PEzkli@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FbNFQ5sDJVddyUQeYRVt2DuWFbucCyOX
X-Proofpoint-ORIG-GUID: FbNFQ5sDJVddyUQeYRVt2DuWFbucCyOX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDI0NCBTYWx0ZWRfX9mMvUAnyeH32
 +Bz3jwM7PufZgS6q+GrZvynh85QubtjVR6OWmpx5nZ93upxV81ESRCQtTOpKbzx+t6awW4RWGgF
 2jBY8PCxL3QxUyPOuPcR4peAwsc2YNyTCG3niDbX0A8L8+KsUwMFk1ec5VH6z+yCLK0t2VLdAq1
 DFeNZawyTCiHxAkUuh87gy9VllpjeMRy/zpjwqRDgs5IwvrpGfJievF+BTzvOIw9/59b5//gaGs
 PGl5e319K39P6qfTVbyYrRnxj7kdIpJUvU14gJfB6zgT8K6lCEVRratlvSDWzDu0LR2K3FtcT7d
 K4GtdDgPlpAauugHCsTnuuUTzbt6YOgnS1KQAz77sp95rfgYTK/JQX45OksmR4Z7tN9hajN8PZF
 0r4xBxZzjmNsx8jDwzURMzR114eCFGPgu7bOY2kmYQ0da3Kl1AvJ7lMz4UnCKx6/Whu9WF4BOo/
 IgeLJptgu+7GHkonbfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDI0NCBTYWx0ZWRfXyP4cAoZnlqVd
 II9OP0bPIcrdjaq0to5fw6gEAzcZ83k1zJKNP3nlnxJj0XXQ5HGYX73Su2VTtgkahfCGn5XfnmC
 5ZEj8X464f0qS/xNTtBHHu5czTIHnco=
X-Authority-Analysis: v=2.4 cv=YsQ/gYYX c=1 sm=1 tr=0 ts=6a5d4621 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=QyXUC8HyAAAA:8 a=eKJpgwECBEAPCD-rYWYA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190244

On Sun, 19 Jul 2026 11:47:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Jul 19, 2026 at 02:51:58AM +0300, Rupesh Majhi wrote:
> > Add triggered buffer support so pressure and temperature can be captured
> > into a buffer instead of only through one-shot sysfs reads.
> > 
> > Pressure is a processed value in kPa computed from a non-linear
> > calibration polynomial. To keep full resolution in the buffer without
> > disagreeing with the sysfs unit, add raw and scale attributes for
> > pressure (raw in Pa, scale 1/1000 to kPa), following bme680; the existing
> > processed attribute is kept for ABI compatibility. Temperature is already
> > a full-resolution value in its base unit (millidegrees Celsius) and stays
> > a processed channel.
> > 
> > Pressure compensation depends on a temperature reading, so both channels
> > are always captured together. The device already runs in continuous
> > background mode, so no buffer setup ops are needed. Sysfs reads and
> > reconfiguration return -EBUSY while the buffer is enabled, as they share
> > the capture path's raw values and configuration.  
> 
> Do not reply to the same thread with a new version.
> Do not reply within less than 24h.
> 
> The change needs more work, See my comments below.
> 
> ...
> 
> > +	/* Buffer to hold a scan; timestamp is naturally aligned */
> > +	struct {
> > +		s32 chan[2];
> > +		aligned_s64 timestamp;
> > +	} scan __aligned(8);  
> 
> We have a macro for this (alignment). Or even for the entire struct.

If (and I haven't checked) that is the required alignment it doesn't
need any marking at all.  The C spec requires a structure to be aligned
to the alignment of it's largest member.  Here alignment is forced to 8
by the aligned_s64.

> 
> ...
> 
> > +static const unsigned long dps310_scan_masks[] = { GENMASK(1, 0), 0 };  
> 
> Jonathan usually asks to provide a bit-wise definitions and use them here
> instead of GENMASK().
> 
> ...
> 
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/* Raw pressure is in Pa; scale to kPa per IIO ABI */
> > +		*val = 1;
> > +		*val2 = 1000;  
> 
> So, we have KILO in units.h.
> 
> > +		return IIO_VAL_FRACTIONAL;  
> 

