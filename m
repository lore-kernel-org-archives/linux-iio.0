Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF1225B30D
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077705; cv=none; b=tXEzdCknt88bCK3W91XomU23jIladNQP+ahDXmVIDqwrVrL3QlXoqhYDCWqD6Knd1X5HdkNECkWeUVbGGRaL0S0QYSpyd4QyX7DJ/E0l6VJYMapb6ybMlc6OZXGVstK3Kx2CTFSfc7MaawvZ03AhYgKeto2Vkn4iBe4RNtPFMZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077705; c=relaxed/simple;
	bh=tN35dLZPzwzi+5Sd9xksFVjFrsn7f2K4Ef6bj0jV96g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOwCflO8f9rwBp9DhvSVEQemk1VQffq1hX+0l794rJDa3Hb1C6Kb00Ags/6jBpNmivt0zz9Tp1giubyWSpESGnoLILjRn3duqBnsyWFqss5L8sM6jM9jx+9bIy32Ckx7wiLHJUNwvfhUoQDul7tQGi8YmAZvN8YOCzgJwkAknlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bTIv3TVG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jCrhHjPd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bTIv3TVG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jCrhHjPd"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F0IXbI2049685
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 01:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aXTMMshAVtUeQo0IZUDx3gK+TpvQrcV476loM7bSKzc=; b=bTIv3TVGY9TPZ32r
	WeYkeoiwDe+S4dCEL46RoqTcV9RQrbX3KUXFsbpgCmcgjE4iqFbEEopQlayy3D+W
	HGoovpmQnRJAO1OOOORAJFG1ZRT1XJ/zVmYBY1HT7Vlj03rQzoll0REwAOma2JZV
	lvmg4mzOa60ASK1WPwKkUSIpnG4LAdCLwegm77fih29cktCXfBwq0ihd5Pb/YpS/
	oejQr3Mo09H8pvoCETvplmeoVqw0WGxkwAgPayWNYZqEPLRwwmtjFBb2IHbrHjs0
	8KtLsWNLQZSySO/jlKYjYFcP7Y0OqMvwDgwh0qsJr3PcEWYQaA0QW2TQ39H1hsTZ
	E6Y/Cw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdwk30g4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 01:08:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487eb67173so7753120b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 18:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784077696; x=1784682496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aXTMMshAVtUeQo0IZUDx3gK+TpvQrcV476loM7bSKzc=;
        b=jCrhHjPdiSt1PJFwxwdvi980LWTS+oRBSsRAjfeCqYO869sOiTkZIUOSRxwP2req5p
         9AJQNIUhVNiBwQWCqcprC4YnkoHy3Fl4miar3p+PSQpJLdy2k8nAO9vCD5gKpUe8sW1+
         YQCA1gDAno5EbuWz3aKKdHg+KVb2IS30Z4juAEuQskNRojriISwKxSRrX3tHlQZtNPjy
         issubbGRGLyuUX10MtZIXhZuSYBRBAeuk1LzImCat1S5J29YfPpTW8OT8cQ/1lCel6JV
         3xI36SVW3PKEMIbrlWDNqJjLGrhu8JoYVpQf1eek3Inof1lDedrKLvYvGWyi1GSlo6Qq
         YgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784077696; x=1784682496;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aXTMMshAVtUeQo0IZUDx3gK+TpvQrcV476loM7bSKzc=;
        b=bRs7YEWca0uSXGSKpKMnjVGA+c14wDjYF6BMmPKfVjbxW1qiAncft+UdA29oOszfXg
         vra/PnYKlUZokS1PzaH5UxWG7+S//rdSpwChYaAkT9s5R63ctv6Zj6XTWbXn3kfwwmlm
         FZEjb+pVrb3IzUkcddRVfo5HfXsB/LflV8s6DG5TnhX377xkPTbjzcT3uKDS88sceOnG
         KWPQLmJekJ36yUnOtXZ2ccK1rdL16AYPOzBJBIPh9GD2+ryAYJ61KckbT69bVYpIJQP/
         aAg57CV0/4Ly1vTAjsm+G5Mu6BMMwlJ2iqHF8X0guiLCeVDrapfNEgOw7X4LTjEXd9vd
         Xw1w==
X-Forwarded-Encrypted: i=1; AHgh+RrGEI7JwkwSdbCcXiF9FAj2e/zmEBdH77lHx3DrKAnmGam16YaXkJFemgA6IAUYBIyWYwMTX0lSh9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdo3eQlVtRU0k14WPzIjaVXeaQ29plt3qyu9Pbcc/kaYrmF8a8
	wvdpb4DktMDK1Km3UzhSB8+ellPXQHAvxBWx2MtnUIjY2QYt46cwa736JuvhGLvn6FPsUOm6WTv
	kQ6NC+Y+UREf2yuLB9E9qUOopURMdPTWOq6doCcDlaaC+rPl/je6stwm+Gs4H9eM=
X-Gm-Gg: AfdE7clVGfJ0JUnN/ggEBwC1zmWdQMJPME0MCZY/C6ilTTfmFW6w9JXHMyQJ0FtHKYi
	1hriMmR3HfrhtrpG9QdxawAxNVjB3ESXaC/96AGxKjgttJGmP3tLDZ4KG6na2cTJ8o0Cirz96oP
	mtFvoDm2CSNtcLowThpkPPjUSOxyxV/6vXPpmsA4zmiwre9LphatADUBQbk4MI75qHyNAdPgzHI
	1KVge5KT+9X/ySGBeclJ2C7DNBDh579D3hiCUzQQLyDy4ntYMgdrnHCy2XEcZEaz8rqc9/saom3
	emMsWNm0Mh2+z62+gXmoYznRLqnpIxHPnubkFmsr2Y4zG8DaK7Dsexu0dtyQdPy+i9RzVh6iv41
	ft2+qP2L2kX9a9od9rclZKYoXbbOnsobPsrZW
X-Received: by 2002:a05:6a21:694:b0:3c0:9c1a:8937 with SMTP id adf61e73a8af0-3c34d8b2322mr7739460637.63.1784077696492;
        Tue, 14 Jul 2026 18:08:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:694:b0:3c0:9c1a:8937 with SMTP id adf61e73a8af0-3c34d8b2322mr7739430637.63.1784077696047;
        Tue, 14 Jul 2026 18:08:16 -0700 (PDT)
Received: from localhost ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm78642078c88.1.2026.07.14.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:08:15 -0700 (PDT)
Date: Tue, 14 Jul 2026 18:08:12 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 07/17] iio: test: add kunit tests for channel prefix
 naming generation
Message-ID: <20260714180812.000070c4@oss.qualcomm.com>
In-Reply-To: <egyms7ulkxsgu4pvfkoruelec3sf6ca4bndcuqkvxljrdluqwu@edlqne7oy3xs>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
	<20260707-ad9910-iio-driver-v7-7-a4ec30f63700@analog.com>
	<20260712020928.2c8d1667@jic23-huawei>
	<egyms7ulkxsgu4pvfkoruelec3sf6ca4bndcuqkvxljrdluqwu@edlqne7oy3xs>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yc6NIQRf c=1 sm=1 tr=0 ts=6a56dd81 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=7zneujqQnARXn4JFaX0A:9
 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: XC_J01McGBh0wK1idBCgLgtYldIW1xKK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAwOCBTYWx0ZWRfXxOByjnmLaWXT
 lbTk4mKNqIE8en/J6fzd+qNDuV9MBIQpXjeNklNfiZrChHa7Qi7znIfuAs4iNoH9im1Wz4Au/lZ
 am4O2iXsbInkU07jpJ9TXUyGktM5JoAIEndg3P/PHO6Pm787G9UgoecQEO/rFhGeDrHrYDzEF7u
 W4X1iytdiwuHX34M/HR5+MJK36A2ykwepUxaf0He740bS2HLDZlLDOxfgLpPwPHxhT9mSXR1WBR
 tPlLXJLO+2yAEuelkll+RnDY+zPxHU8Qdiy/VtrTK6WqOBgREnUyXd1bnFJ31300C1iOipbL9oz
 BkQpemAyv7uw3qQUwqPXsdg83458PHfphwOn1MVuf094VpO16fYtQ0VFO2kPJemgSVZCmJvWFCk
 8upV4GYK29bhGYdQr9EIVgDufcU5lHI2faSttJTooBUW0P8mo1XWtxIaRZLbsaBWTjBzC07KMPC
 oausMC6MlhTrHh+J+qA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAwOCBTYWx0ZWRfXyxqtPPIwPzM1
 n24NOEqa5+Sqe4T8m0sxvOBocFoLrdweV9jcWfdIS5ZXwJ026hdw6nAbq3pggfmgXBf0Is1vWr7
 v7g6kw7XxD2T4eqOCw5tvtmyig9Apto=
X-Proofpoint-GUID: XC_J01McGBh0wK1idBCgLgtYldIW1xKK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150008

On Mon, 13 Jul 2026 10:52:56 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 12/07/26 02:09, Jonathan Cameron wrote:
> > On Tue, 07 Jul 2026 15:04:28 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add a KUnit test suite covering __iio_chan_prefix_emit(), the helper
> > > that builds IIO sysfs attribute name prefixes from an iio_chan_spec.
> > > The suite groups cases by the enum iio_shared_by mode it exercises:
> > > 
> > >   - IIO_SHARED_BY_ALL: produces an empty prefix.
> > >   - IIO_SHARED_BY_DIR: emits direction only ("in" / "out").
> > >   - IIO_SHARED_BY_TYPE: emits "<dir>_<type>" and the differential
> > >     "<dir>_<type>-<type>" variant.
> > >   - IIO_SEPARATE: covers the full matrix of indexed, differential,
> > >     modified, output and extend_name combinations, plus the two
> > >     documented error paths (differential without indexed, differential
> > >     with modifier).
> > > 
> > > A final case exercises the seq_buf overflow path by passing an
> > > undersized buffer and expects -EOVERFLOW.
> > > 
> > > Because __iio_chan_prefix_emit() is static, the test translation unit
> > > is pulled into industrialio-core.c.  
> > 
> > Isn't there some magic route cases like this that makes it non static
> > only when self tests are enabled? 
> > Claude tells me to look at include/kunit/visibility.h  
> 
> There is, Although I think that using
> 
> 	#if IS_ENABLED(CONFIG_IIO_CHANNEL_PREFIX_KUNIT_TEST)
> 		#include "test/iio-test-channel-prefix.c"
> 	#endif
> 
> was more straight forward, less invasive and easier to change than..
> 
> 	/* In "drivers/iio/industrialio-core.c" */
> 
> 	#include <kunit/visibility.h>
> 	...
> 	VISIBLE_IF_KUNIT ssize_t __iio_chan_prefix_emit(...)
> 	{
> 	...
> 	}
> 	EXPORT_SYMBOL_IF_KUNIT(__iio_chan_prefix_emit);
> 
> 	/* In "iio_core.h" */
> 
> 	#if IS_ENABLED(CONFIG_KUNIT)
> 		ssize_t __iio_chan_prefix_emit(...);
> 	#endif
> 
> 	/* In "drivers/iio/test/iio-test-channel-prefix.c" */
> 
> 	#include <kunit/visibility.h>
> 	#include <iio_core.h>
> 	...
> 	MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> 	...
> 	// Use __iio_chan_prefix_emit() in tests

I'd rather this wasn't built into the core module.  So prefer you jump
though those hoops.

Jonathan

> 
> > 
> > Very nice.  A couple of really small additions requested inline.
> > I might well have missed where you exercised the corners requested though!
> > + I'll need an Ack from Lars for that maintainers entry. I'll guess that
> > Lars won't give one as not very active at the moment in this area.
> > 
> > Jonathan
> >   
> > > 
> > > Also, an entry is created under MAINTAINERS dedicated to tests for IIO
> > > core helpers.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---
> > >  MAINTAINERS                                |   8 +
> > >  drivers/iio/industrialio-core.c            |   4 +
> > >  drivers/iio/test/Kconfig                   |  14 ++
> > >  drivers/iio/test/iio-test-channel-prefix.c | 246 +++++++++++++++++++++++++++++
> > >  4 files changed, 272 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 2b1ec46c5919..57ffc0dcfdb6 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12634,6 +12634,14 @@ F:	include/dt-bindings/iio/
> > >  F:	include/linux/iio/
> > >  F:	tools/iio/
> > >  
> > > +IIO CORE KUNIT TESTS
> > > +M:	Lars-Peter Clausen <lars@metafoo.de>  
> > 
> > I'd need an Ack from Lars for this entry.   If we don't get one are you
> > fine looking after this without Lars listed?    
> 
> That is fine, will drop his name.
> 

