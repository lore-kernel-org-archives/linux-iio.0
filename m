Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CEC3793A5
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993986; cv=none; b=aQNHJQGivN+5QfvyzRfq9XJf820m0yGlFy77XtqBk5qY/avfTv3EEYzFjM1dnvwwtSNVYlsLkGjC/Kq71anFF5kJocQU50mBpWqBlntfx+sKOASVZtHuyROsQu5D6nWX1EbXmI8vZ6KmTBpsF5TJjy/4l/whYq0DcWZ9YafNwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993986; c=relaxed/simple;
	bh=q8TVETNa1uE3QUakKka5wxyaWqWkAanfGgfq/fhYx9g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 In-Reply-To:References; b=hkQbne3BTVTIodpr9smlEkfD1Z+L8GRoEZ7s+GKzO7bVbn/rh6CxGKiwZkMp+jm1BPZDEVGpXsZQbVHnyAtvCDVirVW5bIhl4Cd4ibJDqn1pzIIAavDTrDrlRTkfJ8ZngG1Ywl7g5E3TNDAsxYRRkfAjTFmrVg+LjLIS8uBMP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=F+COuLel; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=SNLCZ/6q; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="F+COuLel";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="SNLCZ/6q"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=F+COuLelrPY0V9czSHOolQ2fJpFEH+kEhimcIrP55YXoTtXiiqJVtvSWtxjLppfW+el1gajOGLl/Vr3jmPsEG8zuKhr61MdiKpoiw/RV1hI56IleEwy8NtQx19XVDbHBbGVgov40ZgDoRw4vwn+Zc1s+5Rc0UbCI0B8yuFyUzTpWrBeP1ldUEowlWMyx+lM859xcRlJFDFdbKmen9w00A+RM+LMtFO5Ti2rRC9JGS+cRfzZHbDvQ19qNS4N1QX/6I3MwBIqDsgnrtEyqIoccKsFNYqmk4M7cg/AzsDjdSOKF2dFmMTuAr2qvDoWiLka5BeRK4hKvjxmvdu+Euyg9tg==; s=purelymail3; d=maxwelld.cc; v=1; bh=q8TVETNa1uE3QUakKka5wxyaWqWkAanfGgfq/fhYx9g=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=SNLCZ/6qDCHM+1JbuW0973wPgSaGcLbMUpqXlwq5Ee2DAzM02zrJdMdgOceC7YGSZwyGOrbf3LtVEdFvzeuTMfToAHja7Xw4XA9s3/Ui/XrmVKqEMMKQ9poB7Zr1XV2oV4TKF65FpSNL7lo5bjsw0LNLQK0fJ+t88CrgXPOKtPMe8DXh/xOpWpdom3uijmP/BQyltkme/0qb8xfIFO7wjYlu75ivRFR6VkdJJiCLYq9BdBTvp2uSGHprrSbFxIZmBB76STqImWb43ddA3fneJ4McUOjXlawyaq827+wYj9QzVdBLqJwVj1k8U9AGvgrVweLdWh9yCYpynqsKkEyuww==; s=purelymail3; d=purelymail.com; v=1; bh=q8TVETNa1uE3QUakKka5wxyaWqWkAanfGgfq/fhYx9g=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1190427768;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 17 Aug 2026 19:12:57 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 14:12:56 -0500
Message-Id: <DKRGHVP0FO9A.1VS4B0R21J97C@maxwelld.cc>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
From: "Maxwell Doose" <maxwell@maxwelld.cc>
To: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
Cc: "Joshua Crofts" <joshua.crofts1@gmail.com>, "Maxwell Doose"
 <maxwell@maxwelld.cc>, "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Marius Cristea"
 <marius.cristea@microchip.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Tomasz Duszynski" <tduszyns@gmail.com>, "Jean-Baptiste
 Maneyrol" <jean-baptiste.maneyrol@tdk.com>
In-Reply-To: <20260817035414.496912f4@jic23-huawei>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
 <DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
 <CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
 <DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc>
 <an7OSM04kiviu9xL@ashevche-desk.local>
 <CALoEA-xkxGY9sTeTR3cXgzadp+Uuk3MZh21ubD82kyijo4NN8g@mail.gmail.com>
 <an7W8VKXrIKzl9xt@ashevche-desk.local>
 <20260817035414.496912f4@jic23-huawei>

On Sun Aug 16, 2026 at 9:54 PM CDT
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 14 Aug 2026 11:50:57 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> On Fri, Aug 14, 2026 at 10:25:32AM +0200, Joshua Crofts wrote:
>> > On Fri, 14 Aug 2026 at 10:16, Andy Shevchenko
>> > <andriy.shevchenko@linux.intel.com> wrote: =20
>> > > On Thu, Aug 13, 2026 at 09:47:00PM -0500, Maxwell Doose wrote: =20
>> > > > On Thu Aug 13, 2026 at 3:47 PM CDT
>> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
>> > > > > On Thu, Aug 13, 2026 at 8:52=E2=80=AFPM Maxwell Doose <maxwell@m=
axwelld.cc> wrote: =20
>>=20
>> ...
>>=20
>> > > > > Note, that kernel.h shouldn't be there at all, but that is defin=
itely out
>> > > > > of scope here. =20
>> > > >
>> > > > Makes sense. I wonder if it may be worth doing a patch series remo=
ving
>> > > > all of the kernel.h inclusions in IIO all at once (or maybe some d=
rivers
>> > > > have a legitimate use for it, but that seems highly unlikely). =20
>> > >
>> > > Yes, for sure! I have simply had no time to do it myself, but I have=
 a low-prio
>> > > item in my always grown TODO list. So, if you do that, I will really=
 appreciate!
>> > > But be careful, the actual patches should care about the whole bunch=
 of the
>> > > inclusions, and not just about kernel.h. This means each driver shou=
ld be
>> > > carefully inspected in accordance with the IWYU principles. =20
>> >=20
>> > This will be a gruelling task (implementing and reviewing), but perhap=
s it
>> > would be easier to do one sensor type at a time instead of the entire
>> > subsystem. =20
> Absolutely. One patch per driver for this and not more than 10 ish
> drivers in a series or out for review at a tiem.  This stuff is still qui=
te
> tricky to review, even with details on why each header change below the -=
--
>
> Also precursor patches for any significant reordering to put them in alph=
abetical
> + block for IIO headers just to make it easier to read the patch that cle=
ans
> up what is included.
>
> I've done some of these as have many others. It's worthy work but slow to
> do!  I'd suggest we leave it as a newbie task, but it requires more under=
standing
> than typical for one of those - so if you want to take it on (probably ta=
ke
> a year or more to finish given review bandwidth!) then that would be most
> welcome.
>

What we ought to do is start by removing all of the kernel.h inclusions
and then we can go into each individual driver and do IWYU on them. Not
sure if we want all of the IWYU stuff (including kernel.h removal)
rolled up into one patch per driver or if we want to split patches into
kernel.h removal and then IWYU (hopefully this time I can get iwyu-tool
setup so it won't be *as* gruelling). Or in the case of we leave it as a
newbie task maybe we just add it to the TODO (since this is probably one
of those things that happens over time when we revisit drivers).

thanks,
max

>>=20
>> I would start from the easy cases where kernel.h is just not used at all=
 (not
>> even as a "proxy" header). Then continue with the rest.
>
> yeah - if there are cheap ones were we can just drop it and now do the
> rest of the work then I don't mind seeing those on their own.
>
> Jonathan
>>=20
>> Joshua, note, it's only about the drivers that have explicit kernel.h
>> inclusion. In general the entire IIO needs to be revisited, indeed.
>>=20
>> $ git grep -n -lw linux/kernel.h -- drivers/iio/ | wc -l
>> 234
>>=20
>> $ git ls-files | grep ^drivers/iio/.*\.c$ | wc -l
>> 707
>>=20

