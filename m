Return-Path: <SRS0=h0xK=ZM=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v8 12/12] mux: support simplified bindings for single-user
 gpio mux
To: Rob Herring <robh@kernel.org>
References: <1484755035-25927-1-git-send-email-peda@axentia.se>
 <1484755035-25927-13-git-send-email-peda@axentia.se>
 <33b29f7e-3e48-b85d-ccf9-93b1d67ac634@kernel.org>
 <d32f335f-56f2-38c1-e4d9-4629926dbe21@axentia.se>
 <20170127155202.z2ufbq5bdtclk5oo@rob-hp-laptop>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-i2c@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <67bc8a1c-7067-700f-2b69-12a76d91b2ba@axentia.se>
Date: Mon, 30 Jan 2017 09:02:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170127155202.z2ufbq5bdtclk5oo@rob-hp-laptop>
Content-Type: multipart/mixed;
	boundary="------------E50455DC8AFC88E8331704A6"
List-ID: <linux-iio@vger.kernel.org>

--------------E50455DC8AFC88E8331704A6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 2017-01-27 16:52, Rob Herring wrote:
> On Mon, Jan 23, 2017 at 11:24:18AM +0100, Peter Rosin wrote:
>> On 2017-01-22 14:30, Jonathan Cameron wrote:
>>> On 18/01/17 15:57, Peter Rosin wrote:
>>>> Allow bindings for a GPIO controlled mux to be specified in the
>>>> mux consumer node.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> Code is good as far as I am concerned. Only question is whether this
>>
>> Hmmm, now that I think some more about it, the code supporting the
>> simplified binding (patch 12/12) is a bit fishy in one respect.
>>
>> A driver that calls mux_control_get and gets a mux_control that happens
>> to be backed by an implicit mux chip (i.e. using the simplified binding)
>> will not be able to reverse the resource allocation with less than a
>> complete destruction of itself. Now, this is likely not a problem in
>> most cases, but I bet it will creep up at the most inopportune time. And
>> your remark that I'm the one that has to maintain this makes me dislike
>> this concept...
>>
>> I.e. mux_control_put *should* reverse mux_control_get, but this simply
>> does not happen for the implicit mux chips, as implicit mux chips are
>> not put away until the owning device is put away.
> 
> I think this is because you aren't creating a device in this case. Nodes 
> in DT are not the only way to create devices. Drivers can create a child 
> device when they find mux-gpios property.

Yes, but even with such a child device, a flag is needed somewhere that
triggers cleanup when the mux_control is put away. And then it is possible
to cleanup w/o the help of a child device. I wrote some code for this when
I realized the problem, and it looks simple enough, but I haven't tested
it yet, so who knows... It is attached (patch to be applied on top of 12/12)
if anyone cares.

>> Every time I have tried to come up with a way to implement the simplified
>> bindings I seem to hit one of these subtleties.
>>
>>> is worth the hassle given the normal bindings don't give that high
>>> a burden in complexity!
> 
> I was going to change my mind here, but we already have "mux-gpios" as a 
> binding at least for i2c-gpio-mux. So really the question is do we want 
> to support that here?

I think my preference is to drop the simplified binding, but I can also
live with it. But as there appears to be no strong feelings, let's just
drop it. It is always possible to add it later. Ok?

>> I am missing an ack from Rob though.
>>
>>> I don't really care either way:)
>>
>> But Rob seems to care, this series just has to find a way to get out of
>> his too-much-churn-will-look-at-it-later list. I sadly don't know how to
>> pull that trick...
> 
> By complaining that I'm putting it off... :) I guess I'm okay with this 
> series in general. I will reply on the specific patches today.

Great, it appears that I'm quite the magician. :-) Thanks!

Cheers,
peda


--------------E50455DC8AFC88E8331704A6
Content-Type: text/plain; charset="UTF-8";
	name="0001-mux-fix-cleanup-for-simplified-bindings.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-mux-fix-cleanup-for-simplified-bindings.patch"

>From 5c448b8dfd831c7bc501d9543d48b2077ee1ba7b Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Tue, 24 Jan 2017 16:58:58 +0100
Subject: [PATCH] mux: fix cleanup for simplified bindings

---
 drivers/mux/mux-core.c | 19 ++++++++++++++++++-
 include/linux/mux.h    |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/mux/mux-core.c b/drivers/mux/mux-core.c
index 0caafd6f5a77..53954bd12709 100644
--- a/drivers/mux/mux-core.c
+++ b/drivers/mux/mux-core.c
@@ -321,9 +321,12 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	if (ret == -ENOENT && !mux_name) {
 		mux_chip = mux_gpio_alloc(dev);
 		if (!IS_ERR(mux_chip)) {
+			mux_chip->private = true;
 			ret = devm_mux_chip_register(dev, mux_chip);
-			if (ret < 0)
+			if (ret < 0) {
+				devm_mux_chip_free(dev, mux_chip);
 				return ERR_PTR(ret);
+			}
 			get_device(&mux_chip->dev);
 			return mux_chip->mux;
 		}
@@ -344,6 +347,12 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	if (!mux_chip)
 		return ERR_PTR(-EPROBE_DEFER);
 
+	if (mux_chip->private) {
+		dev_err(dev, "%s: private mux chip specified in %s\n",
+			np->full_name, args.np->full_name);
+		return ERR_PTR(-EBUSY);
+	}
+
 	if (args.args_count > 1 ||
 	    (!args.args_count && (mux_chip->controllers > 1))) {
 		dev_err(dev, "%s: wrong #mux-control-cells for %s\n",
@@ -368,7 +377,15 @@ EXPORT_SYMBOL_GPL(mux_control_get);
 
 void mux_control_put(struct mux_control *mux)
 {
+	bool private = mux->chip->private;
+	struct device *parent = mux->chip->dev.parent;
+
 	put_device(&mux->chip->dev);
+
+	if (private) {
+		devm_mux_chip_unregister(parent, mux->chip);
+		devm_mux_chip_free(parent, mux->chip);
+	}
 }
 EXPORT_SYMBOL_GPL(mux_control_put);
 
diff --git a/include/linux/mux.h b/include/linux/mux.h
index ec9e605d8acf..3ad2e475c9dd 100644
--- a/include/linux/mux.h
+++ b/include/linux/mux.h
@@ -49,6 +49,7 @@ struct mux_control {
  * @mux:		Array of mux controllers that is handled.
  * @dev:		Device structure.
  * @id:			Used to identify the device internally.
+ * @private:		The mux chip is implicitly allocated by a single user.
  * @ops:		Mux controller operations.
  */
 struct mux_chip {
@@ -56,6 +57,7 @@ struct mux_chip {
 	struct mux_control *mux;
 	struct device dev;
 	int id;
+	bool private;
 
 	const struct mux_control_ops *ops;
 };
-- 
2.1.4


--------------E50455DC8AFC88E8331704A6--
