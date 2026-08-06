Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08246390CA3
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025662; cv=pass; b=kLsobWP9DSVZx615spnXpa/hDMGIq/9gBYAt19dX6JDw6YBJe8VcV1oTq7xjoMa3Pzcdg7OqJD2+j4XOjRVhdGQB5oBQldimNhxb9mHuovRUgGj3MER8qWvKAtbEwFFOE3819L2CUvclWagr3BIteRuy6ijW1BRq/pvgyUm/BMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025662; c=relaxed/simple;
	bh=46+6JcjA6rR1QTyo23kusNcDsQJr8RhFi6PkBjNbAdc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R4hvQPuIOK+8/ct4LXRLsg18yVEgMCURhe5GuxOFAWZgJjOVPDbTC8Rt7kWGNT5G4kgY4BRpDsXHNVNHqkr38qXQjKxpNMh7OOPYjjILVJyarvUE3E7rjJKq8TGJqqpnIurRR6Yy2zGGa1BiZRlm27NN7jMtBPAhh47aMnxS6LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blr/mYQl; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blr/mYQl"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso889610a12.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 07:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786025658; cv=none;
        d=google.com; s=arc-20260327;
        b=obpOEX4ypRJFSRWbeI+7y6u1kJVurCYxkmqMR4gEcg/dPjsVmzyk+peNGrRpLMoHQN
         B2TKkzhR2kdW8WaZVmTctp/SMPq7FW2E24+u+oEeGsxYuIkf14dIZs90Dvo/n4PVIxI5
         8IaEQqq8GMtXyEx2+EUn9KL9J2uJ2G+3tS4Kh9cjn3sjO/mONtwe10O6n/aJAdqCSUMx
         3sMpPsRYuYbx5rhNOwHfbxkxl9Cvc+2vTMAB7FbjEaGneKnMLxvvNFfDbvDU8B5MMKGf
         O7/MPiEO7uOv1iprfKFBdGSu6AocVSYpm+/4HBQbM+vRzphJya86p5b7RG7pOszTyXfd
         0z/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=46+6JcjA6rR1QTyo23kusNcDsQJr8RhFi6PkBjNbAdc=;
        fh=Aj2P0+JvzE6UE8i6sSCdIt6UDh6uY0ZmQYHH4E3r3aw=;
        b=HTQ9fWmvhQ4cMsx4CuybhcZy/Iw554U9nKNCBCooD8i/GtkNE200KRGvhWxJjfmwJc
         v4qym0e1dIMIpBG7oPisNrAwKhsKm4aGJA/0cU9l7t23f/Zr8Bu6MKb2sIfGjixlAJL9
         Z47+vjWFOJXPVMIngD0LjKIUOJ3yKfrSMV2sh0Ty4ojPliaKbDqOP5asOmPPFVBmoX66
         4+TYGPiFzyPDlLpj/6ku9v6qypX+pgX4BgiGVmhpdceMGVtrfsjxN+hfGAsp6Il+QdHw
         mHFl7arw2YzdBworYENxMUpB0PjDSD6i5wADPZc0staQRBJNe8D+PXYlW5j8ZylvW/26
         lpRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786025658; x=1786630458; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=46+6JcjA6rR1QTyo23kusNcDsQJr8RhFi6PkBjNbAdc=;
        b=blr/mYQlnKQU0et8FG3B6vi/I4ZaiPIhUbqaQAVU5lgokjamnWhREUUfidzdU29RAP
         7YqRFyVZfClwpIxUTlIijSxR6AYfLjEQIyZzKQGmQtEiO2fOvl9MLnmitHZf5rpD0gvA
         AU9+CbIjRs3csIiWjbMOUabUrLjU4lj5Emfa0+ssJPsnWTA7JY3+IyxLlmd3art4Cktj
         Pvqoa0JXq4KvkXeJ78SESi8LppLKCvri8n6QSyY4JV02D46vn8zTXxnceNVWWFFWeZHW
         XFW8VX+h49mqgaI7bp19MDLRoyQzGRl3ouDbjwVXenn9kId8IRnxnoHohwtZ7PGFVdUO
         xV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025658; x=1786630458;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=46+6JcjA6rR1QTyo23kusNcDsQJr8RhFi6PkBjNbAdc=;
        b=lUScfKc6Ye+iorz5MHKk+r2lgehxrX1+TjZSOeATJKj7FhpQdEU76dqxn344wsTDRL
         NdMWXGTBzZF6eHfHNmI8z7NiIFkmN2bZp1xzfw6v87g3w6pTn1NmRrtc25IJoicE9CCf
         TObg/cars8jt+ZPksb0SvLa4g3LkuRwOrgHG6THvgkztVeMOTzfbb95u6bGUnA9qYbiI
         Wa7LRDGEGpL9YZw3q10DwXg4t5mVdu0R8rUMtoo0+t/Cjf07IuD/HTad2XXv7DKyJ/rH
         vEyMc/KZqFRDoPoPINRTT+OisGB8FZAMJEBAgI9E7M8JJsCNgEK84eQ9qhuHnmPxMR49
         ehiQ==
X-Gm-Message-State: AOJu0Yz1gBaWoz+HhKdU0/Ei0EcEepm2yIB1lQB8epQ2h3a7aq/fIKw1
	CyvrsJdOnlZxg8XmPKPY59chluW2wOKDUNKLVjbIBktvn8LgqJwfoY3q+x7B7wlOwkFUXuTYP/q
	heMifNeCLIyn0A0ZmiARDLIBk7mvKOlqcB1ix
X-Gm-Gg: AR+sD11P5rHg0cYT8gPbM2ybqvVn1pj1b7JyAxpsnTsUKhzASlcu3UNYaVs0E8QKhV0
	NS1ZHV7ZLEmKYJiF7bsuRz54WjR/2uwg9Sg1594RuAd33BgI8N4AJKbyCZIyWTFK8SiVdNxaoiW
	+ojSwCCsovAInWPJUx76zF1+di3bwx7mZT1RfPDVCJiniFq5zhtdY9Cn8p5JhuqZRG/ykFwp96N
	5sCBLeksA8qN2KxKF7tNDTVApmnTHdS9qIlVdMGHK8S+DjIEpqhmdBc6MLPjBmCzzcWWJr0PLb8
	igrAZZI4zHb89nfFOsZOzyODk4Vu1DwQ42Cv021rmhn9VPD2dtukHjislwLrdQxQn1FyHAGh0KO
	jw/4TVAQCVxePjROA4O+f/VA43z5fhfvh5w==
X-Received: by 2002:a05:6402:a0c9:b0:6a0:926e:f8f9 with SMTP id
 4fb4d7f45d1cf-6a1b4a9e9c8mr1139610a12.2.1786025657529; Thu, 06 Aug 2026
 07:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Olivier Tanoh <olivier.tanoh19@gmail.com>
Date: Thu, 6 Aug 2026 16:14:05 +0200
X-Gm-Features: AUfX_my-AHn15nDLn3sdNVQS9_K6dWjM0r1262xHTl7Pz5OygNB6RwCJyxMasNU
Message-ID: <CAM49wQtRt5JWDWZtu4Kc-Lk9miv-Uc0nYocd7JFiTVycXQExkw@mail.gmail.com>
Subject: Guidance for a first IIO sensor driver contribution
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm an embedded Linux engineer looking to contribute my first sensor
driver to IIO. I'm familiar with the submission process (I've had
patches merged to staging), and I've studied the structure of existing
IIO drivers, si7005.c in particular, so I'm comfortable with probe,
channel definitions and read_raw.

I have I2C hardware for testing (Raspberry Pi CM4), so I can buy a
part and validate on real hardware.

My difficulty is picking a target. Most of the simple
temperature/humidity sensors I looked at (SHT3x, AHT20, ...) already
have hwmon drivers, and the recent parts I found in vendor catalogs
(e.g. MAX30210) are already being submitted upstream.

Two questions:

Are there sensors the IIO community would like to see supported that
currently have no driver?
For a sensor that already has an hwmon driver, is an IIO driver
considered worthwhile (for buffer/trigger support), or is that
generally seen as redundant?

I'd rather pick something useful than duplicate existing work. Any
guidance would be appreciated.

Thanks,
Olivier Tanoh
