Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171221E47CC
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577441; cv=none; b=Vd+QUllHxThCriKnhIibALNN1bs66vyQc2DIcnh+joKz/iG54WMcnLEa3KAKxmv0ynmfq38MrwJd9tcvgnXPcm4FKfQ4Z5KdGzl3+tiJIbjFFn8bxCw/dkDrYIiB8pE5e8oUoQ9TrupeztJlVnTrZRmrRD5Ab8CXq41GP6Ll+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577441; c=relaxed/simple;
	bh=KJesWsbuDzQpkNp8k17t23YomF1fs6T42RqnGIbmT+M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ODqpCaN3g/KzChavr0496fkgczqJ8asNhELhfqbfDMdPbabUHXufpu6pblbWn9JG1BpmRtFmtsDDpkCCtoYwQpeCJRQWMZDZaB7vMzA+VMm3tQ7yQSRJ4EdkICqHkK66F0TICCsCep68YT078lejrcmptsTPcpRBMCDUlidiBwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGbttGbc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGbttGbc"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b461310af5so5499625ad.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577439; x=1778182239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxuNSv+nlSzXKcfeo3FfuQD7X7e1NhixT6Zs+fqDCx0=;
        b=JGbttGbc+tG+gUSPvjEJ0qXv+SCE9UzH/cRWyBAWzAoDWWQ33JNC8IkdrLwQfqxJRC
         p83OVs2oBraSpsEuOlb7JLakBEXcH/pQ5USAFV3nmbM9776vNyU7CUgNM3aWTeYjIFRI
         DFyvzq+bpI7vaXxweouctvSwHNh0BiSdA24GR8dQdZijB3csvA5qffGFj4WknMk9nGfx
         zZiyxS85z6ybeDu7HcCB3q3WSyQpHFTxfL9ucSffQT8CHL4j/Ot5ureduJjjPPVrDZ2j
         Z5VniMYVqDuIUzTBBkPHoOrnrF6wLM5OfhfhOAWGMnKisu5YjMYM2rj0hFB1c31duSTL
         7o9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577439; x=1778182239;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxuNSv+nlSzXKcfeo3FfuQD7X7e1NhixT6Zs+fqDCx0=;
        b=PdLk/bG71uYlZBFVDe+VJzWYcfyj6TF3ZERK4eaxPqjN1nB50EyT+IHVTzdKctlvfS
         oszuOatIiuzjAK9FEExEbbboUiS1/y1HXuEkevNb+ni1g3xOnKaTdxz8INNQruDpO915
         E/6XoIQxukfwmPnrkBhVEWQfwU1DOpFqxbADkknjkb4VFpbIV2l56DzP2TyUUNeYehhr
         KfByqEhSyXNZNHgzK4j8Pj3vKU6exXPs+vVugEHxaMoJI30f2ZZ3/m4f70hckRwXIety
         Y/1V+K4SySQPlpT77Fj9GuJGem4lATUo1QxIuXZwWUGnjJQ8Af8YMObuA/X+U5PnPcGd
         NhSA==
X-Forwarded-Encrypted: i=1; AFNElJ+LY6bJcvV1Dst5uCRhiF3BPo1sXi5tsZ/UoJT2cOj2LjZQxyVd0ZTh2YwF90I8ITCygwKdLabO6lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcvuMnLvEC2IsXviWfiQn2NanXL3d4Gy3+8oB9PsELr7+DZyYs
	rN22bFwX8AoYpHrBm3s6BPXTKHNPys6vwMH+9BJhXaAXZ2sdzt3me03B
X-Gm-Gg: AeBDievJB6q5XEqaWJ+MdhiuR8GNhGlEZNeM+I9MrO49/iu+12xFMySvR/772qxisiX
	5TbUuK2uPgzSHFj2w/CI2H44lpzL3rd7P4/9AUmBkatE7B7kl4X7EFl8jQg4jW0HnpWHwnanmjz
	w7IntRVpbeXPBBZfFe1LRyaqYwDCPOVzvoiGgbuevgEbyAj0752zWniVE4kM/1eAN9jP/6xWJBs
	C3WC559E4M3D9OJPrF+0fxhfcA5qIVNzqC/JJUU+XH7ZY0gbuj5S8hhxjDV4DRju/uOLpHGXqu4
	8oLy+7sJx5H1mKJe3cdsLsZkwNDu1hNke/97pDW4xnhsIrOYKpiobGI4SC1KjoVah1SeEAM3cSp
	cHcfJGzOgGWDLsHtboya+Z+teVJ5IrLkQAhxv9NUyEb49NtFJkVOXkU2jq3AH73xpZfn5p4+qzq
	sR2YS72lRpKq9mx+ReSjNdq2HdquSDm4MDoB+xMK8oHI1z
X-Received: by 2002:a17:902:ef11:b0:2b2:5070:8b with SMTP id d9443c01a7336-2b9a428297cmr33927525ad.1.1777577439347;
        Thu, 30 Apr 2026 12:30:39 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:53d0:4e4d::e3d:bc05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaaec82sm3750855ad.24.2026.04.30.12.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 12:30:38 -0700 (PDT)
Date: Fri, 01 May 2026 01:00:31 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: hid-sensors: introduce device managed API
User-Agent: Thunderbird for Android
In-Reply-To: <afJcj34Fc_aUMVhe@ashevche-desk.local>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com> <20260429175918.2541914-3-sanjayembedded@gmail.com> <afJcj34Fc_aUMVhe@ashevche-desk.local>
Message-ID: <D8E78026-517D-4CE8-927E-6F4AC7E21454@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 30 April 2026 1:01:27=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 29, 2026 at 11:29:16PM +0530, Sanjay Chitroda wrote:
>
>> hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
>> prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
>> during setup and release using device managed framework during drivers
>> fail, unbind or remove path=2E
>>=20
>> Register action with devm_add_action_or_reset() to release resource wit=
h
>> devres framework=2E
>
>=2E=2E=2E
>
>> +static void hid_sensor_remove_trigger_action(void *ptr)
>> +{
>> +	struct hid_sensor_common *attrb =3D ptr;
>> +
>> +	hid_sensor_remove_trigger(attrb);
>> +}
>
>Casting is not needed here=2E
>
>static void hid_sensor_remove_trigger_action(void *attrb)
>{
>	hid_sensor_remove_trigger(attrb);
>}
>

True, the cast isn=E2=80=99t required=2E I kept the typed variable for cla=
rity and type checking on devm_add=2E=2E API which pass void * callback and=
 remove trigger API which has struct hid_sensor_common=2E

Happy to simplify if preferred=2E

>=2E=2E=2E
>
>> +int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *=
indio_dev,
>> +				  const char *name, struct hid_sensor_common *attrb)
>> +{
>> +	int ret;
>> +
>> +	ret =3D hid_sensor_setup_trigger(indio_dev, name, attrb);
>> +	if (ret)
>> +		return ret;
>
>> +	ret =3D devm_add_action_or_reset(dev, hid_sensor_remove_trigger_actio=
n, attrb);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>
>	return devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, a=
ttrb);
>

Agree, will update in next series=2E
Thanks,
Sanjay Chitroda

>> +}
>
