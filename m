Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820685;
	b=wZTrb8D9wfAuHpqAidwvfk5TKF4EzRKoNPqngB+ZRYQ9GAO3CXzGAzm2XaD9E8nt0B2M
	 O4Q7hd3rMdj2aGddrf5fgsKlY7IjT5VGnlyzNpbHWsFakGdCJDHg2uCwgrkGLSG+e9shK
	 CmDvkchAz3DXNjuQpxKVlxAWr9Icv4Lm59zm2aBrxbZ0OnYE07yWNZMToiwbWJlch8lW2
	 tbmUf3fnyEh8elaXJveVX5pix3tJsbYjAUPA7+JBxUIOdcLkNvOHzu9RJFjap1jqNPSi3
	 h+KDHdC7fFL8egcYVKucZ9m2Dg3A4i44HoSxXm9x9nYVaR1UGUo9V3srCq2gkfV2g2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=ZzX+Y1+WYbWKOk6oennD0Dv0zMIBzdD9xecwmJHFZfc=;
	b=vXXkUn9EJXvLfqnFRgDWdblhJkCXyZDZef3XPAsI3HU0FbzJse/mCzvOIjm22sL1BuDM
	 Pr1yKOaeOVqtEARZ9o+k/wT73WpfrTTLgzb1mIVeEZ8QqebLpHJTQJQTgvwZidbzRYA/8
	 GvfewCO0U0dI54gJ49V3kbtjx7e9L1T6uwBZzqN7XdjfiPOs9Z/FRdFcAsP0xmLp0/t9B
	 Ctq6jSty2oXOAKaRx7as4OMh7UNHAzYtVpNM69vpmufvqe2zSFcO+Gi4ycsYDVPfA9Df2
	 L9kYsUB+9FZg5PNcjrg2SSXfitBmjAmv1p36i5818vF/tmcuxFv3hp9wP6K4HGOnvMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ebiCagEc;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9056098F63
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 19:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9056098F63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ebiCagEc
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-19305bcb72cso1044796c88.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 11:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793820684; x=1794425484; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZzX+Y1+WYbWKOk6oennD0Dv0zMIBzdD9xecwmJHFZfc=;
        b=ebiCagEcv9jB6n5sa23e1q9YIH20vvBybwTpWuRaFE9enzofxxJUKZky5VAXZ9U9+B
         6hJh0sdDX/cKfI3AA1HSed1ssW4IK9a3kg8HijPbPC+3mtOPsxwBBkq5bMEQMAKstOwW
         7jLR0kDPv0fK5mOSmCNUkdqdq3PdPFnNbKikU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820684; x=1794425484;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZzX+Y1+WYbWKOk6oennD0Dv0zMIBzdD9xecwmJHFZfc=;
        b=a2nO31GuG6/c9ApwHkIk3GhoPFM0RftH41J9LXEsYD+kyXshpoP6d2RmyZlepdvrW4
         HfdjchY/GtQZwfIukzI0XcU79Lf+EgERkeeNrVa7tWIZcgu1UbT+8auNa9KaacUZDDk+
         1d+trF4MheRSORG3DNcAUpalMKohi/tnnRMhnQ3O6AdOrQeUZN9xEBECN4TgqJBg50fO
         PbJ2NiixbLRg6FKvSmP7w7oErKOLCwbNW0RcgZpSLxYNAIHy/KzcYhKn84H8n5k6UsJT
         fW+s40R4lT+xPKYV4wg7OIjaKRTnLIr/bWUrYbzY2F+EO1pMYAZ77kSdsFW/bbjQW9OP
         PK1A==
X-Forwarded-Encrypted: i=1; AKwUvBzypj78yetSR8ckgu3MpUov/z3FDQt5L7MhI9QxD7Dl57kJmw+8WKnXXEzXqdndoHD6IJ4uYUFJ/S8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b/4IBy/ZOtireT23AdIvM+zfxTpxCc8PaTQjCf2Up0IZM5+ix
	fqRu+1pcfzGGPq0Gd1UOy1DLpGWLT9lP+lEfP2tLLLaPcw/DeDAApXjoXQ5hWusEcg==
X-Gm-Gg: AYBFou3w0+dNeQqa9frDThGjYhHOVbL4NGKb9W9CIyIDNJTH7R+qDRHZRwayMMdM6oI
	PeSoUM7f8OFYPO4pU76o/n4xE1OiQwgA8FcJ9T10jDDcSJOqmFhS4G1hrVVHw+DyRf/HkLN3/34
	HTs2H5ifoQ9knOB1ZPRnu4Wp9nmJVzkC5FljPP0JfTAQs6aWVsUAnwYjRk4tjX0p6t5UeYYWw/p
	LTG5DtIdxQcwLbaeHZoFY5P+5E9Ya7mvlV24J4tPdGQwrF3CopG71WYpykmu7sCBIU4eQy8sfYA
	MLW4LiPQyxPKekRpi2GLmTYfEA91288/CIm+ZystNAJEfG2j11OL6lGjIFuULId27nBA7lnsHD1
	8mG/FyHMdaaZO/JsWi9o6Z0vz/aXsG3xVf+MSRhxliWmfTX63ux4kXDjo3AZa/cIuj6kWxeRynR
	3A1pxQ1zn3IxkFFOAHNiESLm0BDnN/quBUR0Iy6csnNXyueGuqJr/zzg8TLNY+QmOGdguiwqqhk
	htpNxB9RB94cdLUINafi4lEDC57aYxOaVt/eaFjCPammi74fIyH258bX86GI8+ypNWLltgaMIJN
	3t561JmKfNUgRL2a7WsL8aHjycDZ8bXz12yJGJGgNJ/GBMMl/nybePoipXFW3ooh8XQ=
X-Received: by 2002:a05:7022:3f0a:b0:144:fa57:c617 with SMTP id a92af1059eb24-1ac5c55546cmr28416697c88.34.1793820683864;
        Wed, 04 Nov 2026 11:31:23 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:1a56:21f2:3dba:7453])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245c748eesm9683024c88.23.2026.11.04.11.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 11:31:23 -0800 (PST)
Date: Wed, 4 Nov 2026 11:31:20 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH v2 3/5] PM: runtime: Propagate last_busy from dependent
 to dependency
Message-ID: <auuICAm4BC_8Pzs5@google.com>
References: <20261103221717.3840215-1-briannorris@chromium.org>
 <20261103141442.v2.3.I40c0bc917fa0b13111251844e9a54feb1d9cd7d2@changeid>
 <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jWCz0XDgzeETbmMfGOmvh2G9qcx7xLODrpQ9NiwsddKA@mail.gmail.com>

On Wed, Nov 04, 2026 at 02:34:22PM +0100, Rafael J. Wysocki (Intel) wrote:
> I should have responded to the v1 of this, but didn't manage to get to
> it.  Sorry about that.

Hehe, well that's what v2 is for :)

Thanks for looking.

> On Tue, Nov 3, 2026 at 11:23 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > When a child device suspends, it does not update the last_busy timestamp
> > for its parent. If that parent configured autosuspend and didn't
> > otherwise maintain its last_busy timestamp, it may now be immediately
> > eligible to suspend. This is probably not expected -- the parent should
> > wait for its autosuspend delay before suspending.
> 
> Let's first talk about what autosuspend is for: My understanding is
> that it is there to avoid incurring the runtime PM suspend and resume
> latency (and cost in terms of energy) in the cases when the device is
> known or at least is expected to be needed in the near future.  IOW,
> we want to defer the runtime suspend of the device because if it
> suspended, it would be resumed shortly thereafter.
> 
> I'm not sure if that is always the case when a dependent device
> suspends and its reference to the parent/supplier is dropped.

To be clear: dropping a reference is not the point at which we extend
the timer -- it's simply the point at which we propagate the last_busy
timestamp.

The naive algorithm is:
Every time a device updates its last_busy, sync that timestamp to all
its dependencies.

My proposal modifies that naive algorithm so that it avoids additional
graph walks -- it defers that "sync" step until later. (Now that I'm
spelling this out, I feel like I should have included this in the commit
message...)

With that said:

> The core calls pm_runtime_mark_last_busy() for resuming devices under
> the assumption that they are resumed for a reason and so it is likely
> that they will be needed in near future, but I'm not sure if that
> assumption can be extended to a child suspend case.

But that's not what I'm doing: I'm not calling mark_last_busy() -- I'm
just making mark_last_busy() transitive to all dependencies. So any time
we *already* say the child is busy, I also extend that to the parent --
I'm not generating any new timestamps; I only reuse the timestamps we
already selected.

My view on the logic (using your terms above): when a child calls
mark_last_busy(), it suggests that child might be needed in the near
future. Whenever a child device is needed, so is its parent (barring
ignore_children). Thus, mark_last_busy() should also refresh the
parent's busy timestamp.

Importantly (in the same topic Jonathan was already asking about): this
does *not* mean the parent gets a whole new autosuspend delay period --
but it *does* mean that if the parent has a longer delay period
(presumably because it has a more expensive/slow suspend/resume latency)
it waits a bit longer (in case the child wakes back up, for one) to
autosuspend.

In concrete terms of commit c537d3457542 ("iio: adc: stm32-adc: fix
runtime autosuspend delay when slow polling"):

 * child device has 100ms delay
 * parent devices has 2s delay

SEQUENCE:
 1) child is active for longer than 2 seconds
 2) [timestamp N] child finishes I/O, drops reference with put_autosuspend()
 3) [N + 100ms] child suspends

CURRENT BEHVIOR:
 4) [N + 100ms] parent suspends immediately after #3

PROPOSAL:
 4) [N + 2s] parent suspends (if there was no other last_busy update)

The only last_busy timestamp is N; we just use it in more places,
because the parent was, in fact, busy at timestamp N.

> One might argue
> though that extending it to the child/consumer resume case would make
> sense.
> 
> > The effect of this behavior is that a parent device may suspend sooner
> > than its autosuspend delay, simply because its usage was accounted by
> > its children, and not by direct references to the parent device.
> 
> The distinction between "direct references to the parent device" and
> "usage accounted for by its children" is not clear to me TBH.

"Direct reference" is to mean "pm_runtime_put_autosuspend()" or anything
similar that updates last_busy. We expect that when the device in
question is the target object for I/O or whatever is keeping the device
busy.

But if the I/O is performed by a child, then it's no longer "direct
reference" -- it's "usage accounted by its children".

> There are references to the parent device in both cases and it is not
> like drivers can always expect all runtime PM references to come from
> specific code paths updating last_busy.  There is at least one
> reference controlled by user space (the "control" attribute in sysfs)
> and dropping it may also cause the device to suspend immediately if
> last_busy has not been updated recently.  How is this situation
> different from the one related to child/consumer suspend?

I think I've improperly directed you to focus on the "reference" part,
which IMO is a bit of a distraction. The point is: when was the device
"busy" (or "last used")? The 'control' attribute does not represent
"last used"; it just represents some unrelated policy to prevent
suspension.

> > This was noticed in several cases, and some have implemented
> > workarounds, such as in commit c537d3457542 ("iio: adc: stm32-adc: fix
> > runtime autosuspend delay when slow polling"). At the same time, Ulf
> > suggested these problems "should be solved in the runtime PM core" [1].
> 
> So I need to be explained how commit 9bdbb1139ca1 ("iio: adc:
> stm32-adc: add power management support") works because ATM I don't
> seem to understand it.  It looks to me like the .runtime_idle()
> callback updates last_busy for the device for which it is called, not
> for its parent.

Note: stm32-adc-core (drivers/iio/adc/stm32-adc-core.c) is the parent.
stm32-adc (drivers/iio/adc/stm32-adc.c) is the child.

When the child suspends, the parent checks .runtime_idle(). This updates
last_busy but still falls through to autosuspend -- that means we get a
slightly suboptimal sequence like the following:

 1) child is active for longer than 2 seconds
 2) [timestamp N] child finishes I/O, drops reference with put_autosuspend()
 3) [N + 100ms] child suspends
 4) parent runtime_idle() updates last_busy to [P = approx N + 100ms]
 5) [P + 2s] parent suspends

Step 5 happens approximately 100ms later than it really should, but it's
good enough.

NB: I think this is also why greybus (gb_bundle_idle(),
gb_interface_runtime_idle(), etc.) and USB (usb_runtime_idle(),
dwc3_runtime_idle()) look the way they do, with a built-in
mark_last_busy() in runtime_idle().

I also think that some other areas could use some logic like this. For
example, drivers/pci/pcie/portdrv.c has a 100ms autosuspend delay so
that lspci doesn't cause repeated suspend/resume. But suppose config
access for a child of a port are slow ... then the port still might
suspend immediately, between config accesses. (Never mind that
pci_config_pm_runtime_put() doesn't update last_busy...)

> > Instead of working around the problem in drivers, we propagate last_busy
> > timestamps from a dependent device to its dependencies any time it may
> > allow a dependency to suspend -- i.e., when releasing a refcount for its
> > parent or suppliers. We take care to only propagate the timestamp if it
> > is larger than the existing busy timestamp.
> 
> I'm not sure why propagating last_busy timestamps when dropping the
> reference to the parent/supplier is a good idea.
> 
> Why is the child's last_busy timestamp suitable for the parent in the
> first place?

I think that's an area I could improve in the commit message. But see my
comments above ("My view on the logic") which I hope answers your
question.

> Why isn't done when dropping the reference?
> 
> > Note that this works best if the dependent device is using autosuspend
> > (and therefore updates its last_busy timestamps appropriately), but even
> > for a non-autosuspend child, this is still somewhat useful --
> > non-autosuspend devices still automatically update their last_busy every
> > time they resume.
> >
> > Link: https://lore.kernel.org/all/CAPDyKFp=KTf8=zGBSzPYqhjnZpY8xwvjCeM1e-WTKT1QLSxaDA@mail.gmail.com/ [1]
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > Cc: Ulf Hansson <ulfh@kernel.org>
> >
> > Changes in v2:
> >  * Update comments to explain when/why rpm_propagate_last_busy()
> >    performs the update
> >
> >  drivers/base/power/runtime.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 2a117d6a776f..dd306cbabcd3 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -318,6 +318,22 @@ static int rpm_get_suppliers(struct device *dev)
> >         return 0;
> >  }
> >
> > +/*
> > + * Propagate last_busy timestamp from one device to another, typically when a
> > + * device (@dev) releases a reference count on a dependency (@target) and might
> > + * allow it to (auto)suspend. This can, for example, prevent overactive suspend
> > + * when a dependency's usage is primarily driven by one of its dependents.
> 
> AFAIAC, you need to say much more than this to explain all of it.

OK. If we agree on the what and why, I'll take another pass at this. For
one, I imagine describing the "naive algorithm" I mention above would be
a good start. And maybe the principles below.

> > + */
> > +static void rpm_propagate_last_busy(struct device *dev, struct device *target)
> > +{
> > +       s64 busy = atomic64_read(&dev->power.last_busy);
> > +       s64 target_busy = atomic64_read(&target->power.last_busy);
> > +
> > +       while (target_busy < busy)
> > +               if (atomic64_try_cmpxchg(&target->power.last_busy, &target_busy, busy))
> > +                       return;
> > +}
> 
> And I'd rather not do anything like the above unless absolutely necessary.

Which part do you not like? The loop? The use of compare/exchange?

The principles involved are:

1) copy the timestamp
2) avoid going backward in time (e.g., if target already updated to a
   newer stamp)
3) avoid TOCTOU races between reading the target stamp and replacing it
   (e.g., if multiple children are doing this at the same time)

I suppose I could compromise on #3 by only doing a single
compare/exchange. This would remove the looping (which is admittedly a
little hard to reason about), at the expense of getting a suboptimal
update in the (likely rare) case of concurrent updates.

Brian

> > +
> >  /**
> >   * pm_runtime_release_supplier - Drop references to device link's supplier.
> >   * @link: Target device link.
> > @@ -348,6 +364,7 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
> >                 if (!device_link_test(link, DL_FLAG_PM_RUNTIME))
> >                         continue;
> >
> > +               rpm_propagate_last_busy(dev, link->supplier);
> >                 pm_runtime_release_supplier(link);
> >                 if (try_to_suspend)
> >                         pm_request_idle(link->supplier);
> > @@ -710,6 +727,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
> >
> >         if (dev->parent) {
> >                 parent = dev->parent;
> > +               if (!parent->power.ignore_children)
> > +                       rpm_propagate_last_busy(dev, parent);
> >                 atomic_add_unless(&parent->power.child_count, -1, 0);
> >         }
> >         wake_up_all(&dev->power.wait_queue);
> > @@ -1368,8 +1387,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
> >                 goto out_set;
> >
> >         if (status == RPM_SUSPENDED) {
> > -               atomic_add_unless(&parent->power.child_count, -1, 0);
> >                 notify_parent = !parent->power.ignore_children;
> > +               if (notify_parent)
> > +                       rpm_propagate_last_busy(dev, parent);
> > +               atomic_add_unless(&parent->power.child_count, -1, 0);
> >         } else {
> >                 spin_lock_nested(&parent->power.lock, SINGLE_DEPTH_NESTING);
> >
> > --
