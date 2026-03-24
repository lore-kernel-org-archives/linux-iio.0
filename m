Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D54405AD5
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365468; cv=none; b=uxf5ETJY5xVOLO4Rt1lmL0hcyaa8Ay4JNm+DJhlb8h8CVTII5ovhQV/KWEReH0axa/pgTea3Hn5XaqPqPIjZ700VcJ1TqdvIVsfhgy9PoS41R0nk7ve6I0t+1bZFGrpOiZzII3w/SP88APBfQMDzUfH4HkH1nYOZ3z2NRvStLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365468; c=relaxed/simple;
	bh=Q9gRqFrvyUHsVjhObb3HseEeq2F31kvgSUewzTp3A8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKNBVm6rVJZReMEWLbn/Ht83Zc8Qba8nTXlAehtPyXE1g6NbD4PbDxuySubBczN5YxuRDeV6IVPbuyTzhcw13dgGh7xPk1IKJVetMk9m2y8QczMdfGkoO6ZB7PaaCFcqlcOJ0HZt1sl6RdbwqqzLPgdX4HwFrICUcqfZuEjUZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64edb56b70cso748452d50.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365466; x=1774970266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9gRqFrvyUHsVjhObb3HseEeq2F31kvgSUewzTp3A8E=;
        b=BJHnnCQwv+BADYCcAohCahya6nUfRv09OrbIr3m9jv2CVaGiuLyDZ0DzB8/xZ6Cmfb
         bdQ4aT3PdrKq+Wp99O4fPfiXzbTh8IEiBsl0aQrQBwhnhWWzAMnBQSUIG0iDhuiPadKS
         JeuL0RCrY+Sovp07epagluu4BAAzu8Comwb32EK7shURhBHLhHB0envuWC5Db7dMhEOU
         ux9hwbkaekNUWf7HLH/8FVejKYz+HMPdELgNXSA/QuKZdM0u8dO+FatCeK6x0Nf0VRSO
         gexHuHkZGYsxmtb+vANKQXdQYjifMuwYIpj2aNAJ5qvkgmhrW5Qf0RYjWThQxFdcUMvw
         HzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaeuSI6ff6da3zL0Ser9YqRmBXdbV/xYMUQftrSsbgVWcOHeXuoygHBhxhu8py9VrT9gZJspz/bDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0HocmssmnqKUBNQq4DTh9TOCCwbL3uB3hWfqpSzsUW1dn1pOh
	xEWGN3QV2l3pEQ7dn5l+l2M8C7sngyTCvNaEzpC4cbJBWf/SEG51c05oRas00dgc
X-Gm-Gg: ATEYQzyKgE6Jg7O2TzxnBIn+L2ZR7J0cJeO0KQwmGQt00Ujr1gJhp6aT3Ej57HOmWG+
	ZiU+ij27p6++qlBa65FOrrdkOsUudk8qn9+dxJ7ZMyQ2E9f1FLCpu3PzUClik5W7MbqWndm6Wl1
	dRVjIgJ8GbKZL3yutjgbhZeI7DGMIizpAQh+V2VzGxdofy3gnL7sF7haliEGoDC1H1jtruFn5Dd
	RMElJdMUw+ZIQgxZT5I/EMCRNw+lnTRXo1g2jSwXQYF8iTFcqkMPmqYJb+Bx8A1Rt1bvIjpfUII
	KR7TlGrP6HEmL4KvYNiW6G6loygkVMUfnpmA+vHbh9C7d2SvghgKX4omrs3ALRZNNfgU19W6qD6
	HoKhFfK91qzTjBpHneulbMvx+w5h3SaSMF83Hn1U6FSkEYx8TMnUJ8xVkuXrDWW6EDf+CDgCVrO
	oft6ZoRnSfulVyIZDNO5fMg2KFHjy0Jrw4PL0eYwskXiOYYuQUK2Ij4Cm9uUZvggvdwpIrtE6JV
	64cYvNG320yYpQnRrGTrNPwxPoElWCGOJAm+wn8IIJ1Gw==
X-Received: by 2002:a05:690c:c452:b0:79a:526d:9123 with SMTP id 00721157ae682-79acf6f01e7mr374707b3.62.1774365464936;
        Tue, 24 Mar 2026 08:17:44 -0700 (PDT)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com. [74.125.224.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a90552db6sm74073997b3.27.2026.03.24.08.17.43
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 08:17:43 -0700 (PDT)
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ea73e7b60so4854221d50.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 08:17:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcU7jL0tN2N/MnQEyHna2viqU5JbhFfUG0AXA2Vu1x2vmdUCJxr5YDBB6/UlGxT2/9R3KhD23YyMU=@vger.kernel.org
X-Received: by 2002:a05:690e:104:b0:64d:1a9b:97ec with SMTP id
 956f58d0204a3-64eaa86d5b7mr11928437d50.77.1774365463078; Tue, 24 Mar 2026
 08:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319190738.151614-1-email@sirat.me> <20260319190738.151614-3-email@sirat.me>
 <8502eb51-53c9-4f1b-92d0-21b06fa4802e@baylibre.com> <CANn+LWJEJJoGQU7p2P2GrOcA_g2x7jEnvjcTJYG1hDRUnRw3UA@mail.gmail.com>
 <b1da32d2-e1f7-4fea-82a7-a40e8073a100@baylibre.com> <20260322110319.7d7558f3@jic23-huawei>
 <CANn+LWJwPUiCkz_godEeBvZnXEXzNmCW_-ou=wHL+kjfn0zF_Q@mail.gmail.com>
In-Reply-To: <CANn+LWJwPUiCkz_godEeBvZnXEXzNmCW_-ou=wHL+kjfn0zF_Q@mail.gmail.com>
From: Sirat <email@sirat.me>
Date: Tue, 24 Mar 2026 21:17:31 +0600
X-Gmail-Original-Message-ID: <CANn+LW+OPP2riP1d=zZKz8MnTk2yo2CL3qn17_LYD=1SmCAQgw@mail.gmail.com>
X-Gm-Features: AQROBzDUWip4QF3NJAtaeNw5-aJRGp9zQWHAyV1dFePOzpjcfY75Ufkbu-I_i1Y
Message-ID: <CANn+LW+OPP2riP1d=zZKz8MnTk2yo2CL3qn17_LYD=1SmCAQgw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: proximity: add driver for ST VL53L1X ToF sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 7:52=E2=80=AFPM Sirat <email@sirat.me> wrote:
>
> On Sun, Mar 22, 2026 at 5:03=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sat, 21 Mar 2026 19:37:58 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >
> > > On 3/21/26 5:39 PM, Sirat wrote:
> > > > On Sat, Mar 21, 2026 at 11:09=E2=80=AFPM David Lechner <dlechner@ba=
ylibre.com> wrote:
> > > >>
> > > >> On 3/19/26 2:07 PM, Siratul Islam wrote:
> ...
> > >
> > > If you do a buffered read, which stop ranging when it is done,
> > > then how can the direct read work after that?
> > >
> > > Can we just start and stop ranging momentarily for a direct
> > > read?
> > If the latency is high, then worth considering whether autosuspend
> > and runtime pm can help. That way a burst of reads will see low
> > latency after the first one but we won't be wasting power when
> > no one cares.
> >
> > J
> > >
> > > Otherwise, is seems like we would want to have ranging always
> > > enabled.
> > >
> Maybe we should go with continuous ranging then since it's the
> vendor-intended behaviour.
> Since there is no hardware single-shot mode, by design, I think the
> driver should just behave
> as the hardware intended.
> > >
> >
Just for the record, I'm dropping postenable, and keeping predisable
for only the cleanup.

Thanks,
Sirat
