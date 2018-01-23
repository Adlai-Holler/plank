//
// Board.java
// Autogenerated by plank
//
// DO NOT EDIT - EDITS WILL BE OVERWRITTEN
// @generated
//

package com.pinterest.models;

import android.support.annotation.IntDef;
import com.google.auto.value.AutoValue;
import java.net.URI;
import java.util.Set;
import android.support.annotation.Nullable;
import android.support.annotation.StringDef;
import java.lang.annotation.Retention;
import java.util.Date;
import java.util.List;
import java.lang.annotation.RetentionPolicy;
import java.util.Map;

public interface BoardModel {
    @SerializedName("contributors") @Nullable Set<User> contributors();
    @SerializedName("counts") @Nullable Map<String, Integer> counts();
    @SerializedName("created_at") @Nullable Date createdAt();
    @SerializedName("creator") @Nullable Map<String, String> creator();
    @SerializedName("description") @Nullable String descriptionText();
    @SerializedName("image") Image image();
    @SerializedName("name") @Nullable String name();
    @SerializedName("url") @Nullable URI url();
}

public interface BoardModelBuilder {
    Builder setContributors(@Nullable Set<User> value);
    Builder setCounts(@Nullable Map<String, Integer> value);
    Builder setCreatedAt(@Nullable Date value);
    Builder setCreator(@Nullable Map<String, String> value);
    Builder setDescriptionText(@Nullable String value);
    Builder setImage(Image value);
    Builder setName(@Nullable String value);
    Builder setUrl(@Nullable URI value);
}

@AutoValue
public abstract class Board implements ModelModel {

    public abstract @SerializedName("contributors") @Nullable Set<User> contributors();
    public abstract @SerializedName("counts") @Nullable Map<String, Integer> counts();
    public abstract @SerializedName("created_at") @Nullable Date createdAt();
    public abstract @SerializedName("creator") @Nullable Map<String, String> creator();
    public abstract @SerializedName("description") @Nullable String descriptionText();
    public abstract @SerializedName("image") Image image();
    public abstract @SerializedName("name") @Nullable String name();
    public abstract @SerializedName("url") @Nullable URI url();
    public static Builder builder() {
        return new AutoValue_Board.Builder();
    }
    abstract Builder toBuilder();
    @AutoValue.Builder
    public abstract static class Builder implements ModelModelBuilder {
    
        public abstract Builder setContributors(@Nullable Set<User> value);
        public abstract Builder setCounts(@Nullable Map<String, Integer> value);
        public abstract Builder setCreatedAt(@Nullable Date value);
        public abstract Builder setCreator(@Nullable Map<String, String> value);
        public abstract Builder setDescriptionText(@Nullable String value);
        public abstract Builder setImage(Image value);
        public abstract Builder setName(@Nullable String value);
        public abstract Builder setUrl(@Nullable URI value);
        public abstract Board build();
    
    }
}
