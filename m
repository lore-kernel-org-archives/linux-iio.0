Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1A233928
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246813; cv=pass; b=qtCPSiPzediIz4pjZ+InFxJQsi3npzVt+erOi3A6d42/lfRDU54IGbowaJBGVHCm9HIv5T/xlw/0xN7r++8/D8NojfGKjuJ2Kh+1JQjBHRvvrxFYsG53OMavwAutKN3HcLAELA46r9IQkcMWclQ0k9qpsdMUkwZR/iegp8y3wFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246813; c=relaxed/simple;
	bh=2UCPhXwQ5IhnkhWY0Q7wRfIPQ1oxdh7lu/5FOWSh3u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N07m8YkT3W6fLbe9OvmS9IedZuhyZDpJs5QqPr2OjV9yNLN3s4paZvumBa4wkzLGza943vdqec7cq5iZELs3S9Omn5HnejVF4phef0ThvLopVLSb/QtYZ23yjhrWJULoP/FKpAoLu0gf3q03448of8/cJR9BQ4ltpdwDYyFJn/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daS0Lzim; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daS0Lzim"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65dead17c24so4045766d50.2
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 20:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779246811; cv=none;
        d=google.com; s=arc-20240605;
        b=YtoqZFc3ZiLGYv0M7+UK/9dETbpvFlIau64ZTT57EIi8OYfPdLhEKOTeOZBmV3yDYm
         4m+XROzdzQ0Wepy/SLIIbNkhn2yeZvgqWRNUvlVV8QRhWTuBbAyvNxDjegfgxWRMiKhp
         y/MQ/zKDaRv8//MkcT6dj+VJUfbbNJxZdVM3IYndkGHwTnZKv/mHZ+ox/KjtB1TtCrh2
         Ce5JNVbTOs5bNeDGs6YfkrMkf7VkcNf8ODsA71AHVPDnz1K9NdKPywcUQGUBALG2RnJo
         igr3O1AUZ07WF30/cZwQkwnCzJhp2p4b+p3dXwDtQ47j5mAkxFGa4c97MRUlcT8zPFgi
         kVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9z+A+eqz7jph8RB8HWYKgrBGRWCq0b7uJxvrnIBinAY=;
        fh=All8WwKWNXCPOPyl6h8b6kyVWLGFnZpTQeyUcuBzyx4=;
        b=OMCBrA1eOW0opQ3uW5h4HKzWTJ+JAbXSHcFBS4Ks4OFJErmHTgxuFTvApYE4sR3Syc
         qRYIw73ZYu1umDuBjekFqUoEQvolPiaaitdgizlezJ/JQRJMvVEieZ/BsJjc+NQCg95d
         mcx6fk2Ksam9cpNcgbWq71aAn6CMlrI726fSJfsUQjg9N8Ui6+SC8EcAKoYEIJ5qfKlr
         f9N/AFMkcDejBJq2SXQAVESdFtrVX/bRyyynkG0orXUEkjQw1a2y4UjExMDxvdScokad
         xwm1+dPSsRnoos6HXSfVlDtAP34mb3W8OZ9SgSaITxwAV5yXghC7V7COzBFyq81jzb8c
         E5tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779246811; x=1779851611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z+A+eqz7jph8RB8HWYKgrBGRWCq0b7uJxvrnIBinAY=;
        b=daS0LzimiR1KzZ/3h+xuGkaBqyC9azzNrc+wrGSVrFhHhnZKgyS+qg1D8p6igipQMU
         GcjGyHcD/exe2WbSzSBRijfBRplR62+JdEzhVueCxSxTcPy5yo9xM/8ZKmbpGtxX1+mt
         KZola8mOSX+1Djg9s9kLDchaOunryVWfJ4XFTPjGYuA0mNz1RuNIIoJmkXBBzBUG9urQ
         m1Nea+uLekD7z749qk1qNXCRqsPSO5U49Hw1BZ8dl9AkCIhLf2sTLLWnx/oNDmkAsZaR
         rJ2hKeHkdqDSnT2q1RlAlrluqyrSy82tXqQGHhA/TrKDW6zjzCkJ5xosZ6tBaONeMEM6
         fEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779246811; x=1779851611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9z+A+eqz7jph8RB8HWYKgrBGRWCq0b7uJxvrnIBinAY=;
        b=gMkRqWb5sP8Ny7KJQhoB5YHr+vFN2BtkwOJuaalSKVm/KNycUoQfLVFbiFy0WVJe8d
         3yt4Oz6eyQMZ+HRGcNoGoZo4oAde/D59Ag81SIY0Hs9hBUyLx6ELn0qu4Z47+COqbUVq
         OHSXhjgGKBvbUVsKNCMz/O/TAqQfaADyWqRhKbDMgd3rOuKDxjE7I4oy++Ckc5lGvZ64
         s+IoZ+5YsM4odePxDXCwtZijELLou6XeAH0rdNfHBJyCtd2HbU77RivDnEAiiBVKINL7
         Zt4iNvzS4uEvCtixo8EDKldPi/bdhjeeZV6sDJ56OlLS4Cjsu0KuGnwn1ViMS+Yxxi/O
         GMWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lyHbfQds9W88f5C8UF9Hv2E+12tVHej4rbHTIYCnkz6ib+Lo0gv0sIHVhflCEQ5cxupp2gveFipY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznXzuWLyWrX5LfQLTOpkR3P7cySiryoCtKeKOsO0GvUrFHiRla
	JEKCk21TSOAMrURnFGJuwfwSEAggQOQERiOcz3DUVjlj8P6Z8T6IJ4V44OS4HEOw68Y8ov4HA3M
	9Q6qznQqSFcD543M83bLpUScdpsXJRmo=
X-Gm-Gg: Acq92OFaMmzYXga69Fm88OROxq5rx1GLLkkZp2L/wx5n0tk9fHU6VapK+0xOwuVyk02
	tm79YLsGMhr97ZZGm0mcQnFJ9fx6ANEGNFe8C6e6FXqNIV/5xJEd0VuHNavxNIiG1j+wp3tWChX
	HHrPqEJo1KPD8hG1Hn7f/bytgxItcC9BNMaq/0RZjEhLlp8MBmjF5O0rrf/NCEfnv6QXqD+grc2
	2x+JOP/Jog1w/oFFdJT9kPlu8GKYhG3zzwiU5/7DQWpwaN9W+KN3/5RWaocC0W0hBaFTKmP1rsT
	jMknl015o19p0YY/rLeKB3o0lQ==
X-Received: by 2002:a05:690e:1541:10b0:65c:6220:5fcb with SMTP id
 956f58d0204a3-65e2281d333mr17390639d50.50.1779246810529; Tue, 19 May 2026
 20:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502234348.131563-1-gabrielblo@ime.usp.br>
 <20260502234348.131563-3-gabrielblo@ime.usp.br> <DI8LMZHMMBVM.1O5Y8WSPHPM1O@gmail.com>
 <CAOmGE-0D3HZEtJcQMrzFh3GrJ4B6T-BJM-ZLDgHE4__bszZuTQ@mail.gmail.com>
In-Reply-To: <CAOmGE-0D3HZEtJcQMrzFh3GrJ4B6T-BJM-ZLDgHE4__bszZuTQ@mail.gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 19 May 2026 22:13:19 -0500
X-Gm-Features: AVHnY4Jj0alG5Ouk-5sT3vtWj-w98_KKJtkaWtxgB1I6biABenWdNJ3GquVJtQE
Message-ID: <CAKqfh0H0+ZQ1PvZyzWdpjYvpMtvEp1WyCC-fnxNC72pqOG9isg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: veml6030: Generalize hw_init for
 veml6030 and veml6035
To: Gabriel Braga Lagrotaria de Oliveira <gabrielblo@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com, 
	jic23@kernel.org, nuno.sa@analog.com, ricardo.kojo@ime.usp.br, 
	elliancarlos@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:22=E2=80=AFPM Gabriel Braga Lagrotaria de Oliveir=
a
<gabrielblo@ime.usp.br> wrote:
>
> On Sat,  2 May 2026, 21:02, Maxwell Doose <m32285159@gmail.com> wrote:
>
>> > Just curious, how was this tested? It seems like you're modifying the
>> > writing logic as well, and ordinarily patches like these don't get
>> > merged unless properly tested. I haven't fully looked over it yet but =
I
>> > just wanted some background before I start.
>>
>> > best regards,
>> > maxwell
>
>
> Hi Maxwell, sorry for the late reply. We did an local boot test using one=
 of the latest debian 14 arm64 images with qemu, and loaded the module with=
 modprobe. Also, we submitted to an internal CI with boot test at https://l=
ore.kernel.ime.usp.br/kernel.ime/
> Link to the pipeline run below:
> https://gitlab.freedesktop.org/marcelomspessoto/dsl-linux/-/pipelines/165=
5734
>

I see. Well that all looks fine to me. Of course incorporate
Jonathan's and Andy's feedback as well.

best regards,
max

(ps, please don't send HTML email, it gets rejected by the kernel
mailing list servers! Send plaintext email instead.)

> Regards,
> Gabriel
>
