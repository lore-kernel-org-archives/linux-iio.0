Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD00222565
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784418954; cv=none; b=bAltoSn8jAnbRbyNb6BIhhjcIAMyeUL6fLVAIi8m1Bznt9sa7iwfA+SyP7QRtj/Z8uMqirRjRsfv7KZFyEeyXPo9Gdi4GyOQ96vcGRRwCgaOtGysXhSb/5sQjXhmNpCUfKUh5ggR7sVr6iDjQ7DK2zo1X4s8XA5ICFNwXWuiTPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784418954; c=relaxed/simple;
	bh=Poh3jDhszcvoCXId/hhPWP1p+RoM4fBjpf3df3Wh5ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAlWyrK5hBMbe+sMLBzGHFLsCOAUQGm5xd3W3qjlDOVqUEJmt4wWsPc39H/T1pj+GXE8OVot/QDsVNkyD+SlMKxHbxK+kvI7Yudy+rj3dj2Iok1ynGJLD+9Cqx1Oxrcp2styMM7ZLxlQ646rWNHgAwi+2ovweTSbIjqsCk9GljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CVBrG5fa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hEhJVTiz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CVBrG5fa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hEhJVTiz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66INQGrQ2126814
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CQ6le/DiMRJDPKAsY3UyvM2R1QeJp8dXELoZtcMNF9g=; b=CVBrG5faNOJoF1Z1
	iPV4oQlX1ZiWFuIzWcsvzhbDrsOE+HK8T9HmtSXCK0DvkpYR7oVkk7k6BZh35yfG
	78RRhLrTCR8n7SY8YK6bYkmL3O7wpKZBpwylk1uIhM8jRNPEHfGMx9QLnaRG31sq
	w5wZvi+cvU1pzNVB2qPI0nwAZr3mNpKcncVGJgG5jPcYvkfcOgkgNP7OgpLrpJSn
	O97dAS2Ml2RqjMM/EcnP3vEbYKak60TB7Qa3XG1k1ShkuyRCXllEv0cNY1O/5Jb7
	4gYRsW7X9KtvknmEMRSZ9IEX7X862VJ1gfZysL8DAWHYmA1In4n7qPK5pXobrDV/
	iv2GzA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2c69su3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 23:55:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5bdd8450dso882702a12.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 16:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784418951; x=1785023751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CQ6le/DiMRJDPKAsY3UyvM2R1QeJp8dXELoZtcMNF9g=;
        b=hEhJVTizEmgVs3ln+8p6kXqXpdi4L7SG/CQmmboeqVPH24wfpJ+J/Ys3TgcQQKlsA/
         n7XdRPULROmkN140jJDLyoitwbgJEYhEVvk3R/Ae4BZQhW9hBNK6iI6BgWuNu+pAX3OO
         BZPFQ2DuiHqtsgjZ0UQTI7NKOAkXdOJUoZ0dqV1zCJ1G+V+X+9yjfCJL0en+pGEthOMu
         krD+vzv3gSfqkW4iHuaIj+j2rmYkhFyvLobNYDuUqajaeQPLp9Oy0RKoWSORKo9U4Amr
         4ofF2lJDLP/P/uOmpj8vv0StpPUKkRCGqO/94Y5QPj46jz9g2ap4NZiech8zjcRtbcn0
         L0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784418951; x=1785023751;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQ6le/DiMRJDPKAsY3UyvM2R1QeJp8dXELoZtcMNF9g=;
        b=Zips2D9tw2FENvA0lSdnY/CLqMmVeIoHtlwzCXLq5v8iM+vs4kprZNF0F3RU6c1KFM
         PzyI+alpstK9bH66VYOjFYov53Fy3l5GDEmc9I6cP77XM4AQa5j8MK6mBWZQ+eHDnwCx
         9usUmnieDhqrV7Isc/VuZPqmWEKF1vg0kq6LEIkCsnLNWh26EhkwWn7u7Z0QOcZnLwQb
         ZyrYe+jg6tqfHofDJ+lf9RbRTK2FO9yARO6sJIDywYReRMjer6ot4nAgik79XfcmN7sV
         MXKPkYFjTplB0CFxCR0hSP/yQroeju0KxV03lPAfoh5wqYQfskfPsMJJigM05wwvgQz+
         aoKg==
X-Forwarded-Encrypted: i=1; AHgh+RqPJZh9i7OXY+GDf/GyDC7q4UQIdDuGNOx5+A192H4qbMrlCPsnnfDtTdGDbYlZk18aKpP7JfXoMl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxiaKfTLGk1hULViF7MpvvgiTUa5jjN3JVPGJMk98YkdxRDBrt
	ofUC01e1CV2de4HRZIRYdd5u74iLngi3b9l0EQ7gf9KUXm0YJ19nZIjjgcXp/OJe5zY3Duzk2D9
	jSqo1adjerwcbj5paKCIEBUCerkG4XuadgHxIvPwKnOVRHXRoS/sG1ZldFTZb5xo=
X-Gm-Gg: AfdE7clOCauHz2VOAK01VGr2ce2Kj3Ya65uzQUecr1N4cBl1O+V4mZ9lr+3+NF4AJpH
	Mq8cFJKHa5Tjh9qjld3vGshkWlQXoWoFWGqFe5YFUqF48hcRE8wBTPjII3EgLmRg3lAW+QqSQJc
	z+FdurwcflbkDAULXjvVMRJq6Xku+MfrU2HaNLSgUd1NAwCgMalOuVzg+xIfAI2MNFeWFXX0MMV
	ytU5XAlFBbYj4krY5ut6AvWZ6nZA5C3igHSQFhV36FdoAXX3dq4vI0Exx2RefTsI3tlbfzaw9LB
	cRx0Vg2SWVowPl2YTRJB2FyRGs+yK+qg7sIrRZA4+9EQ7Y5k7JTkCNmtrDHsxzYY+QfpxikqEt8
	BE413fDNIzty98/na
X-Received: by 2002:a17:90b:2c85:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-38e4b3d14cemr9175755a91.9.1784418950943;
        Sat, 18 Jul 2026 16:55:50 -0700 (PDT)
X-Received: by 2002:a17:90b:2c85:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-38e4b3d14cemr9175741a91.9.1784418950499;
        Sat, 18 Jul 2026 16:55:50 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a0d82d1sm5133549a91.10.2026.07.18.16.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:55:49 -0700 (PDT)
Date: Sun, 19 Jul 2026 00:55:44 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
        Michael Auchter
 <michael.auchter@ni.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match
 data
Message-ID: <20260719005533.41520a27@jic23-huawei>
In-Reply-To: <aloD5HdbntKu--xC@ashevche-desk.local>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
	<20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
	<alkmAcDvSXr_COc_@ashevche-desk.local>
	<ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
	<alnknz55FbyyqqlL@ashevche-desk.local>
	<gy2dn5emz7sreavy6kioz27f3sx2ip6zhkgzs2uz4qzecpkrbe@zgsortof6aqn>
	<aloD5HdbntKu--xC@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x4HK8W4PxkEHD807RchUk9vgREq8IzIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDI1MCBTYWx0ZWRfX9k9DzSFnlOUv
 yJE1VT1Kczew2xPxUi3i8364UXWU5naih/P20SOJqo+jzjkQB0qfMsfOgwb9AWgTZSHjVfAOUCH
 4Q8p/c1hMLc1f+KtTnx0URwy1Qx1vn/AqGBVU0Mz48r6h969JEv/NwZezU4ql2961HM/941KOCu
 HkT3Xivv4GBSDjDjQEUhkhFgTETBlIlNpHKgzwmA/E1jYDUwFBGx03jg7A6uuh76N0rRVwacyDS
 OQa4tgtpQXxSeuh7qwq0GFRKaZt7M0QLGbgEmsJylrXWn2Z91e40Fhn4lTl1ZA3clXmTaMG7ffJ
 +TshL5LIPH8K+juSsFfD9HducrNlw2KiIS4TtJH6Gz3+tsAyFyeM6tGPv1dr7iIcZchtUmaPG99
 afzhT798rn6HWYzvs8NSY46toGAGhUbTGVhlFQUdgL2bmu6OQYFfbgkiLeNqIxdDvPUAkzSCQwR
 nrutqQiI5tpnb1iNRnw==
X-Proofpoint-ORIG-GUID: x4HK8W4PxkEHD807RchUk9vgREq8IzIq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDI1MCBTYWx0ZWRfXzcgoRTHKwy67
 zkFeECPLdAedARiST2eJ2j1ZkFWp9EY7g1tjO1ZiWQEq2unYSVWvxaz1Lhtn1qTurNzhm/wiA6B
 Ty9ApEqHwO+aEwbaigy3sOMUPIL3DFM=
X-Authority-Analysis: v=2.4 cv=CJQamxrD c=1 sm=1 tr=0 ts=6a5c1287 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=QyXUC8HyAAAA:8 a=-JuTqRGIx0hdILrr678A:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180250

On Fri, 17 Jul 2026 13:28:52 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Jul 17, 2026 at 10:31:26AM +0100, Rodrigo Alencar wrote:
> > On 17/07/26 11:15, Andy Shevchenko wrote:  
> > > On Fri, Jul 17, 2026 at 07:51:35AM +0100, Rodrigo Alencar wrote:  
> > > > On 16/07/26 21:42, Andy Shevchenko wrote:  
> > > > > On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:  
> 
> ...
> 
> > > > > >  	struct iio_dev *indio_dev;
> > > > > >  	int ret, i;  
> > > > > 
> > > > > Move an assignment here as well.
> > > > > 
> > > > > 	chip_info = ...  
> > > > 
> > > > assignment? this is an input param validation  
> > > 
> > > Can we make sure we always get a correct one to begin with?
> > > With that an assignment and check can be coupled together.
> > > Also consider use -ENODATA as it's most likely comes from
> > > driver_data.  
> > 
> > I suppose you are suggesting to move the check to the bus code with:
> > 
> > 	info = i2c_get_match_data(i2c);
> > 	if (!info)
> > 		return -ENODATA;
> > 
> > rather than here in the core/common code.  
> 
> Yes! This avoids layering violation and makes the API contract cleaner.

I applied the following rather than going for a v9 for just this:
Shout if I messed it up.

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 8abfaf8f0c46..591596a68004 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -98,8 +98,13 @@ static const struct ad5686_bus_ops ad5686_spi_ops = {
 
 static int ad5686_spi_probe(struct spi_device *spi)
 {
-       return ad5686_probe(&spi->dev, spi_get_device_match_data(spi),
-                           spi->modalias, &ad5686_spi_ops);
+       const struct ad5686_chip_info *chip_info;
+
+       chip_info = spi_get_device_match_data(spi);
+       if (!chip_info)
+               return -ENODEV;
+
+       return ad5686_probe(&spi->dev, chip_info, spi->modalias, &ad5686_spi_ops);
 }
 
 static const struct spi_device_id ad5686_spi_id[] = {
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index d49946adbde3..a6c85d0c33c9 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -68,8 +68,13 @@ static const struct ad5686_bus_ops ad5686_i2c_ops = {
 
 static int ad5686_i2c_probe(struct i2c_client *i2c)
 {
-       return ad5686_probe(&i2c->dev, i2c_get_match_data(i2c),
-                           i2c->name, &ad5686_i2c_ops);
+       const struct ad5686_chip_info *chip_info;
+
+       chip_info = i2c_get_match_data(i2c);
+       if (!chip_info)
+               return -ENODEV;
+
+       return ad5686_probe(&i2c->dev, chip_info, i2c->name, &ad5686_i2c_ops);
 }


> 
> > > > > > +	if (!chip_info)
> > > > > > +		return -ENODEV;  
> 

