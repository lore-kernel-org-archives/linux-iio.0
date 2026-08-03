Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368339DBCD
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741768; cv=pass; b=dR+fuIpRR4ZbSM+6hG3oK/dONDiTejMksVd3tVr9lH4q3gETrkLTRXCFxDCcDbyv5ryTEmtDMOB2XsLdQU2P04rp4HBSudPXQF9q+DrZVlJRdxorY+vsy72nNcYB6Oy1yAHychYahI+z4sPnWII7tZor+wPl6uHpn+bEdNfBLEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741768; c=relaxed/simple;
	bh=NBJfufthfLboGZ0Cc2JRXfGCuyoDmPIK2VnUDe05ddE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLFm6Rq/kksnYIowjf/+BDdE3XUrhaw07wntyCT/CRluFfZY9vtyLyz6irq5GXyqesNlNDRa0N6juZrr1X0JvzAcxUeWQDLaI/sHNdr+JMtl09SV1rdUJkVatyV/bQn/4LqobUKhthJjZXru9q+guQw3AZHF4lVVtZjwx90LzjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjPJQsQr; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjPJQsQr"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e9f7491ffso46650827b3.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 00:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785741766; cv=none;
        d=google.com; s=arc-20260327;
        b=muf+RAGFZ7T+tbvy0bICnriyKvKAsVWlriU+jIxNlGeSC87sGgh7WjPRDb1SNG4VPW
         2wCV+Udz57KQMPKxEQOAKN6f1kq4Xz0KdXu7TKr/uTVRvFgtUFzu3yLKWjFRVMltdyKm
         UsmnSbiMuaDEhdr4bwK6H0fLAI3Q9mptKYcisXo29b080EkduQy7BbiiTI52cEUm5rS2
         a4mQ8Gn4d+sgETC4vWH8PQZypkc8DOv3rzxEJFITipqdNBqRhv+Q8kflT2mFmi+Kv3px
         HsHjhYmywSdH48vRW+9nSa5uFUkE96eLrRxxPDOaksHMek7orwsg5HSLooEnYLi30HWL
         soGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AfQId97c0L0ZUh2S31c0BTp6FzSI+3BrmTgYpNIV5m0=;
        fh=F4OSFL+ggtkR1DCJZtlKXB+r/uwUq+xg8Sll8p/aAQY=;
        b=HjEW6cxK4mrfGpdB+TKbI9QHFfb8Qi3ium3SvRR8sLDah0xZSln8pm9aam0swgZ+gU
         cZzbtPtsh60V2V2SnCJn9kUykh7Fz12wfGs44SmlzhZwjykLIGYpN62Cqa8psQK3E0PW
         Hj+e8sLVL5JaIoymVAdim5BQJUE1+/bB0G8pzAEgstWxnvHiyGQCJIj/NVBrLh1BW1Ua
         L+y71SnQxoEU7CrttLBGQnGoW1iKZXleE7D6qKRJXCYkvClD69BY/5RySyS3bdyT3JD7
         ZkNZKnuPJ5bBo7dA0c4UME0dSeKhGa898xKbAwasuh31JPUmD0iHNMtddtRh7jOI2yeW
         DZlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785741766; x=1786346566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AfQId97c0L0ZUh2S31c0BTp6FzSI+3BrmTgYpNIV5m0=;
        b=SjPJQsQr4AEpREfehO+V1gw+EngKqhUKtumXW9r0bChA36thi3PIK1FSJQLHo5tZjh
         6nVdX4G0MLuG6iIe611jrLxB0NzfSW8WkDBU2h1lj0Ut1T5hjsNAuuFKd7wbHp/78ZX0
         7I+PHmbsEBkw5TlCi/aLakzy8reQjLK3+eHATVrpG9M8qL8FQ1R6D9lPyp77FGsyR+Mf
         ZZK+jDK+boHJa9vzoEfX5CTe9FtzeIPfPpA09y1j9x9d1h0+Q8khlFfKFhsqY45YuKaj
         X3k9y/dCv08g4wCCvrNVmj9qLNgdsqGuNLWbO9Ee4TAGHdzX1IzcoA9GpTsEOpsExiDn
         741w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785741766; x=1786346566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AfQId97c0L0ZUh2S31c0BTp6FzSI+3BrmTgYpNIV5m0=;
        b=X6LCnNdsGM1k3N1QJ1cz66YaPwjSofug+EDphlyqJ7JZ0UrD7cbZrSwjHrMGVXMgCe
         STAUEW4ll5x9Do9yUM1Oci/xQfCiX5z6EU4V3S+HBQNNBTZP8lXJxDyvLtwLgrG5S8+E
         YcNGk7xYE2lRnnvyAPaZDWOkJu6qTJtyL1YZU430AQkST7zzxfoCvmm3BxoIGfHDj/Me
         0wDSoIHQpL9m4ihPzHqPPSKl5honug4+pOES5z/0rHe0lYd+gtC/j+VcX5s6MsjrkCDt
         qjhdnVwzv7VYPbIVQVUFLNWFEMX7O3EaCaMUqSHtg2Ph7vdx6SOMHOkSCv5KuP5/veCP
         jVAg==
X-Forwarded-Encrypted: i=1; AHgh+RqQC4OmpR656VSVWimBDIHu8Go7q6q/CJitNnAPaY2TbG8vjocvUUzKDug/VI+d7JQy9xSCemBE1mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzTby6btVQ0iCv7HRhCXxILvjfJeVQT+ORRnSZJHwazAP7OL3U
	UnP5n1/gPMOp5BYiu56qCKPotbQzNXxPMkitRjnddBPoB2OLc/cuh5c+tqM00XaXDlwsssMPqw5
	C08ME8suUnODZy1fBgugCVjW9JW6NX8qfh4wX
X-Gm-Gg: AR+sD12BFTGZrRGqxYKWSS9uUmCan/4Wl3yiDY2vJZqUFT93tukCgh34mALsjS6TpUy
	oLsT8K1WRm81BBBY4t10nC+mBwzTrpkWr9iLBrCqP0Gnr2BDM7gwKg9sK6mQhvmOOXOppCp943u
	pu65qcuIAJV6B6VTK35dW5UoHhHklaj9V8lQFZ1r+Z2T7+Ibeogj+v7QeBq0THhTyhIsPgTs418
	hRPJxv9aln6OFIFbSfS/bWs+VFn3J3J90fGwgS3NoJhuwPRDdSSz8vTkQzo4zfoBMVyMzNYIoYZ
	hOihh4Eh95bfzdYn8W2+/LbxatV6ThSUZkhZoj9GWEGyfIoB1nL2c4zdlzFgeO02wLrr29wIwAo
	MwsJkYQkUTaRR2pRLZegEaoBpqJr2v5LtgtXoaIry+W/Eig==
X-Received: by 2002:a05:690c:498d:b0:809:fd83:a88b with SMTP id
 00721157ae682-81fd49c3293mr118758967b3.3.1785741766521; Mon, 03 Aug 2026
 00:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727192102.37968-1-architanant5@gmail.com>
 <20260727192102.37968-2-architanant5@gmail.com> <20260801192814.425330a9@jic23-huawei>
In-Reply-To: <20260801192814.425330a9@jic23-huawei>
From: Archit Anant <architanant5@gmail.com>
Date: Mon, 3 Aug 2026 12:52:35 +0530
X-Gm-Features: AUfX_mxtI-rB2iQMvezvXfPQpD10nLrF34HfHZOn14Kl6C0oJNZ_KIvKyV4Aw5Q
Message-ID: <CADJHxWB7mGCxuoDU9u=2KxTr_eiNxHjaTPD+sUMe03mZ2bc7SQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com, 
	u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 11:58=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 28 Jul 2026 00:50:57 +0530
> Archit Anant <architanant5@gmail.com> wrote:
>
> > Replace the deprecated SET_RUNTIME_PM_OPS() with the modern
> > DEFINE_RUNTIME_DEV_PM_OPS() macro. This allows for the removal of the
> > macro automatically handles dropping unused functions when PM is
> > disabled.
> >
> > Update the driver struct to use pm_ptr() to avoid unused variable
> > warnings.
> >
> > Signed-off-by: Archit Anant <architanant5@gmail.com>
> Hi Archit,
>
> This looks fine but did make me look at the code that was being protected
> and in particular ads1015_set_conv_mode()
>
> A few things jump out about that which might make sense for further impro=
vement
> if you want to take them on.
>
>
> > static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
> > {
> >       return regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> >                                 ADS1015_CFG_MOD_MASK,
> >                                 mode << ADS1015_CFG_MOD_SHIFT);#
>
> Use FIELD_PREP() here and drop the ADS1015_CFG_MOD_SHIFT macro.
> That made me wonder how extensive _SHIFT macros are in this driver and th=
e
> answer is very!  Get rid of all of them in favour of FIELD_PREP()
> and FIELD_GREP() and using the field masks.
>
>
> > }
> The other thing is the question of why this function exists at all
> given with the value of mode inline it would be obvious what it is doing
> without the wrapper and this is the only similar little helper function.
>
> I'd squash it so we do the regmap_update_bits() calls directly instead
> of via this helper function.
>
> I did debate whether brining setting conv_invalid into the function made
> sense but on balance I think not.
>
> If you do make these changes, 1 patch for dropping all the _SHIFT
> macros and replacing with FIELD_PREP() / FIELD_GET() and a second
> patch to remove the helper function.

Understood. I'll include these two patches and send the new series shortly.

>
> Thanks,
>
> Jonathan
>

--=20
Sincerely,
Archit Anant
